import 'dart:convert';

import 'package:magicraft_wallet/controller/data/api/network.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/controller/service/ethereum.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/model/local/wallet_request.dart';
import 'package:magicraft_wallet/page/modal/sign/main.dart';
import 'package:magicraft_wallet/service/config/url.dart';
import 'package:magicraft_wallet/service/config/wallet.dart';
import 'package:magicraft_wallet/service/enum/wallet.dart';
import 'package:magicraft_wallet/service/function/log.dart';
import 'package:magicraft_wallet/service/value/encrypt.dart';
import 'package:magicraft_wallet/service/value/wallet.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:hex/hex.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

class WalletAppController extends AuthAppController {
  static late final SessionModel? _session;
  static late final ReownWalletKit walletKit;
  static final _networkData = NetworkDataController();

  static EthPrivateKey? _ethPrivateKey;

  static String? ethAddress;
  static String? btcAddress;
  static String? solAddress;

  static bool isWalletLoaded = false;
  static bool isWalletConnected = false;
  static bool isSwitchingNetwork = false;
  static bool isRejected = false;

  static Future<void> initWalletKit() async {
    walletKit = ReownWalletKit(
      core: ReownCore(
        projectId: WALLET_KIT_PROJECT_ID,
      ),
      metadata: PairingMetadata(
        name: 'Dompet Ku',
        description: 'most secure and reliable web3 wallet',
        url: MAIN_APP_URL,
        icons: [ICON_APP_URL],
        redirect: Redirect(
          native: 'wc://',
          universal: DEEP_LINK_URL,
        ),
      ),
    );

    await walletKit.init();
    await loadWalletFromStorage();
    printLog('Reown WalletKit initialized.');

    walletKit.onSessionProposal.subscribe(_onSessionProposal);
    walletKit.onSessionRequest.subscribe(_onSessionRequest);
    walletKit.onSessionDelete.subscribe((args) {
      printLog(args);
    });
    walletKit.onSessionExpire.subscribe((args) {
      printLog(args);
    });
    // walletKit.onSessionAuthRequest;

    if (walletKit.pairings.getAll().isNotEmpty) {
      printLog('Existing pairings found. Wallet is connected.');
      isWalletConnected = true;
    } else {
      printLog('No existing pairings. Wallet is not connected.');
      isWalletConnected = false;
    }
  }

  static Future<void> loadWalletFromStorage() async {
    final encrypt = EncryptValue();
    _session = AuthAppController.getSession();

    if (_session?.eth?.privateKey != null) {
      _ethPrivateKey = EthPrivateKey.fromHex(
        encrypt.decryptData(_session?.eth?.privateKey ?? ''),
      );
      ethAddress = _session?.eth?.walletAddress?.first;

      printLog('ETH Wallet Loaded: $ethAddress');
    }

    if (_ethPrivateKey != null) {
      isWalletLoaded = true;
      _registerAccountsWithWalletKit();
      printLog('All wallets loaded and accounts registered with WalletKit.');
    } else {
      isWalletLoaded = false;
      printLog('No wallet data found in storage.');
    }
  }

  static void _registerAccountsWithWalletKit() async {
    var listNetwork = await _networkData.getListNeworks();

    for (var network in listNetwork) {
      var chainId = network.chainId ?? '';
      var namespace = chainId.split(':').first;
      var walletAddress = '';

      if (chainId.split(':').first == 'bip122') {
        walletAddress = btcAddress ?? '';
      }

      if (chainId.split(':').first == 'eip155') {
        walletAddress = ethAddress ?? '';
      }

      if (chainId.split(':').first == 'solana') {
        walletAddress = solAddress ?? '';
      }

      walletKit.registerAccount(
        chainId: chainId,
        accountAddress: walletAddress,
      );

      if (chainId.split(':').first != 'bip122') {
        final methodEntries =
            listSupportedMethods[namespace]?.entries ?? const Iterable.empty();

        methodEntries.forEach((handler) {
          if (handler.value != null) {
            walletKit.registerRequestHandler(
              chainId: chainId,
              method: handler.key,
              handler: handler.value as dynamic,
            );
          }
        });
      }

      listEvent.forEach((event) {
        walletKit.registerEventEmitter(
          chainId: chainId,
          event: event,
        );
      });
    }

    if (listNetwork.isNotEmpty) {
      final authApp = AuthAppController();
      await authApp.createListNetwork(listNetwork);
    }
  }

  static Future<void> pairWithUri(String uri) async {
    if (!isWalletLoaded) {
      printLog('Cannot pair, wallet not loaded yet.');
      return;
    }

    try {
      printLog('Attempting to pair with URI: $uri');
      final validUri = Uri.parse(uri);
      final res = await walletKit.pair(uri: validUri);
      printLog(
          'Pairing request sent successfully. Waiting for session proposal...');
      printLog(res.toJson());
    } catch (e, trace) {
      printLog('Error during pairing: $e');
      printLog('Error during pairing: $trace');
    }
  }

  static Future<void> _onSessionProposal(
    SessionProposalEvent? event,
  ) async {
    if (event == null) {
      printLog('received null ebent');
      return;
    }

    final req = WalletRequestModel(
      chainId:
          event.params.generatedNamespaces?.entries.first.value.chains?.first,
      address: event
          .params.generatedNamespaces?.entries.first.value.accounts.first
          .split(":")[2],
      params: event.params.generatedNamespaces?.entries.toList(),
      type: WalletRequestType.WALLET_CONNECT,
    );

    bool approved = await signModal(request: req);

    if (approved) {
      walletKit.approveSession(
        id: event.id,
        namespaces: event.params.generatedNamespaces ?? {},
      );
    } else {
      await walletKit.rejectSession(
        id: event.id,
        reason: Errors.getSdkError(Errors.USER_REJECTED).toSignError(),
      );
    }
  }

  static Future<void> _onSessionRequest(
    SessionRequestEvent? event,
  ) async {
    if (event == null) {
      printLog('received null ebent');
      return;
    }

    printLog(
        'Received session request: Method=${event.method}, Chain=${event.chainId}, Params=${event.params}');

    final params = event.params as List;
    final decoded = HEX.decode(params.first.substring(2));
    final message = utf8.decode(decoded);

    final String fullAddress = event.params['request']['from'] ?? '';
    final List<String> addressParts = fullAddress.split(':');
    final String namespace = addressParts.isNotEmpty ? addressParts[0] : '';
    final String address = addressParts.length > 2 ? addressParts[2] : '';

    final req = WalletRequestModel(
      chainId: event.chainId,
      address: address,
      message: message,
      params: params,
      type: WalletRequestType.SIGNATURE,
    );

    bool userApproved = await signModal(request: req);

    if (!userApproved) {
      walletKit.respondSessionRequest(
        topic: event.topic,
        response: JsonRpcResponse(
          id: event.id,
          error: const JsonRpcError(
            code: 5001,
            message: 'User rejected method',
          ),
        ),
      );
      printLog('User rejected signing request.');
      return;
    }

    dynamic signatureResult;
    try {
      if (namespace == 'eip155' && _ethPrivateKey != null) {
        signatureResult = signMessageETH(
          mode: 'personal',
          message: message,
        );
      } else {
        throw Exception(
            'Unsupported chain or wallet not loaded for chain: $namespace');
      }

      walletKit.respondSessionRequest(
        topic: event.topic,
        response: JsonRpcResponse(
          id: event.id,
          result: signatureResult,
        ),
      );
      printLog('Signing request responded successfully.');
    } catch (e) {
      printLog('Error during signing: $e');
      walletKit.respondSessionRequest(
        topic: event.topic,
        response: JsonRpcResponse(
          id: event.id,
          error: JsonRpcError(
            code: 5001,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  // ETH Method
  static Future<dynamic> ethWalletConnect(
    dynamic params,
  ) async {
    final req = WalletRequestModel(
      params: params,
      type: WalletRequestType.WALLET_CONNECT,
    );

    isRejected = false;
    bool approved = await signModal(request: req);
    isRejected = !approved;

    if (!approved) throw Exception('User rejected request');
    return [
      {"parentCapability": "eth_accounts"}
    ];
  }

  static Future<dynamic> ethAccounts(
    String topic,
    dynamic params,
  ) async {
    if (isRejected) throw Exception('User rejected request');

    late SessionRequest pendingRequest;
    late int requestId;

    if (topic.isNotEmpty) {
      pendingRequest = walletKit.pendingRequests.getAll().last;
      requestId = pendingRequest.id;

      await errWallerNotLoaded(walletKit, topic);
    }

    final result = [_session?.eth?.walletAddress?.first];

    if (topic.isNotEmpty) {
      return await walletKit.respondSessionRequest(
        topic: topic,
        response: JsonRpcResponse(
          id: requestId,
          result: result,
        ),
      );
    }
    return result;
  }

  static Future<dynamic> ethSign(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();

    late SessionRequest pendingRequest;
    late int requestId;
    late String chainId;

    if (topic.isNotEmpty) {
      pendingRequest = walletKit.pendingRequests.getAll().last;
      requestId = pendingRequest.id;
      chainId = pendingRequest.chainId;

      await errWallerNotLoaded(walletKit, topic);
    } else {
      chainId = network.chainId ?? "";
    }

    final decoded = HEX.decode(params.first.substring(2));
    final message = utf8.decode(decoded);

    final approved = await signModal(
      request: WalletRequestModel(
        chainId: chainId,
        address: params.first,
        message: message,
        params: params,
        type: WalletRequestType.SIGNATURE,
      ),
    );

    if (!approved) {
      if (topic.isNotEmpty) {
        return await walletKit.respondSessionRequest(
          topic: topic,
          response: JsonRpcResponse(
            id: requestId,
            jsonrpc: '2.0',
            error: const JsonRpcError(
              code: 5001,
              message: 'User rejected request',
            ),
          ),
        );
      }
      throw Exception('User rejected request');
    }

    final hexSignature = signMessageETH(
      mode: 'eth',
      message: message,
    );

    if (topic.isNotEmpty) {
      return await walletKit.respondSessionRequest(
        topic: topic,
        response: JsonRpcResponse(
          id: requestId,
          jsonrpc: '2.0',
          result: hexSignature,
        ),
      );
    }
    return hexSignature;
  }

  static Future<dynamic> personalSign(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();

    late SessionRequest pendingRequest;
    late int requestId;
    late String chainId;

    if (topic.isNotEmpty) {
      pendingRequest = walletKit.pendingRequests.getAll().last;
      requestId = pendingRequest.id;
      chainId = pendingRequest.chainId;

      await errWallerNotLoaded(walletKit, topic);
    } else {
      chainId = network.chainId ?? '';
    }

    final decoded = HEX.decode(params.first.substring(2));
    final message = utf8.decode(decoded);

    final approved = await signModal(
      request: WalletRequestModel(
        chainId: chainId,
        address: params.first,
        message: message,
        params: params,
        type: WalletRequestType.SIGNATURE,
      ),
    );

    if (!approved) {
      if (topic.isNotEmpty) {
        return await walletKit.respondSessionRequest(
          topic: topic,
          response: JsonRpcResponse(
            id: requestId,
            jsonrpc: '2.0',
            error: const JsonRpcError(
              code: 5001,
              message: 'User rejected request',
            ),
          ),
        );
      }
      throw Exception('User rejected request');
    }

    final hexSignature = signMessageETH(
      mode: 'eth',
      message: message,
    );

    if (topic.isNotEmpty) {
      return await walletKit.respondSessionRequest(
        topic: topic,
        response: JsonRpcResponse(
          id: requestId,
          jsonrpc: '2.0',
          result: hexSignature,
        ),
      );
    }
    return hexSignature;
  }

  static Future<dynamic> ethSignTransaction(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();

    late SessionRequest pendingRequest;
    late int requestId;
    late String chainId;

    if (topic.isNotEmpty) {
      pendingRequest = walletKit.pendingRequests.getAll().last;
      requestId = pendingRequest.id;
      chainId = pendingRequest.chainId;

      await errWallerNotLoaded(walletKit, topic);
    } else {
      chainId = network.chainId ?? "";
    }

    final tx = (params as List<dynamic>).first as Map<String, dynamic>;
    final approved = await signModal(
      request: WalletRequestModel(
        chainId: chainId,
        address: tx['to'],
        message: json.encode(tx),
        params: params,
        type: WalletRequestType.SEND_TRANSACTION,
      ),
    );

    if (!approved) {
      if (topic.isNotEmpty) {
        return await walletKit.respondSessionRequest(
          topic: topic,
          response: JsonRpcResponse(
            id: requestId,
            jsonrpc: '2.0',
            error: const JsonRpcError(
              code: 5001,
              message: 'User rejected request',
            ),
          ),
        );
      }
      throw Exception('User rejected request');
    }

    final signedTx = await excTransactionETH(
      mode: 'sign',
      tx: tx,
      chainId: chainId,
    );

    if (topic.isNotEmpty) {
      return await walletKit.respondSessionRequest(
        topic: topic,
        response: JsonRpcResponse(
          id: requestId,
          jsonrpc: '2.0',
          result: signedTx,
        ),
      );
    }

    return signedTx;
  }

  static Future<dynamic> ethSendTransaction(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();

    late SessionRequest pendingRequest;
    late int requestId;
    late String chainId;

    if (topic.isNotEmpty) {
      pendingRequest = walletKit.pendingRequests.getAll().last;
      requestId = pendingRequest.id;
      chainId = pendingRequest.chainId;

      await errWallerNotLoaded(walletKit, topic);
    } else {
      chainId = network.chainId ?? "";
    }

    final tx = (params as List<dynamic>).first as Map<String, dynamic>;
    final approved = await signModal(
      request: WalletRequestModel(
        chainId: chainId,
        address: tx['to'],
        data: tx['data'],
        params: params,
        type: WalletRequestType.SEND_TRANSACTION,
      ),
    );

    if (!approved) {
      if (topic.isNotEmpty) {
        return await walletKit.respondSessionRequest(
          topic: topic,
          response: JsonRpcResponse(
            id: requestId,
            jsonrpc: '2.0',
            error: const JsonRpcError(
              code: 5001,
              message: 'User rejected request',
            ),
          ),
        );
      }
      throw Exception('User rejected request');
    }

    final signedTx = await excTransactionETH(
      mode: 'send',
      tx: tx,
      chainId: chainId,
    );

    if (topic.isNotEmpty) {
      return await walletKit.respondSessionRequest(
        topic: topic,
        response: JsonRpcResponse(
          id: requestId,
          jsonrpc: '2.0',
          result: signedTx,
        ),
      );
    }

    return signedTx;
  }

  static Future<dynamic> walletSwitchEthereumChain(
    String topic,
    dynamic params,
  ) async {
    if (isSwitchingNetwork) {
      return;
    } else {
      isSwitchingNetwork = true;
    }
    late SessionRequest pendingRequest;
    late int requestId;

    if (topic.isNotEmpty) {
      pendingRequest = walletKit.pendingRequests.getAll().last;
      requestId = pendingRequest.id;
      await errWallerNotLoaded(walletKit, topic);
    }

    final chainParam = (params as List<dynamic>).first as Map<String, dynamic>;
    final chainIdHex = chainParam['chainId'] as String;
    final chainId = int.parse(chainIdHex.replaceFirst('0x', ''), radix: 16);

    final approved = await signModal(
      request: WalletRequestModel(
        chainId: 'eip155:$chainId',
        message: 'Switch Network to eip155:$chainId',
        params: params,
        type: WalletRequestType.CONFIRMATION,
      ),
    );

    if (!approved) {
      isSwitchingNetwork = false;
      if (topic.isNotEmpty) {
        return await walletKit.respondSessionRequest(
          topic: topic,
          response: JsonRpcResponse(
            id: requestId,
            jsonrpc: '2.0',
            error: const JsonRpcError(
              code: 5001,
              message: 'User rejected request',
            ),
          ),
        );
      } else {
        throw Exception('User rejected request');
      }
    }

    final res = await switchChainETH(chainId: 'eip155:$chainId');
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();

    if (res) {
      successToast('Switch network to ${network.network} successfully!');
    } else {
      dangerToast('Switch network not Success or Unsupported!');
    }

    isSwitchingNetwork = false;

    if (topic.isNotEmpty) {
      return await walletKit.respondSessionRequest(
        topic: topic,
        response: JsonRpcResponse(
          id: requestId,
          jsonrpc: '2.0',
          result: null,
        ),
      );
    }
    return null;
  }
}
