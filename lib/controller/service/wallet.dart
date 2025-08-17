import 'dart:convert';

import 'package:magicraft_wallet/controller/data/api/network.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/controller/service/ethereum.dart';
import 'package:magicraft_wallet/controller/service/interaction.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/model/local/wallet_request.dart';
import 'package:magicraft_wallet/page/modal/sign/main.dart';
import 'package:magicraft_wallet/service/enum/wallet.dart';
import 'package:magicraft_wallet/service/function/log.dart';
import 'package:magicraft_wallet/service/value/encrypt.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

class WalletAppController extends AuthAppController {
  static final _networkData = NetworkDataController();

  static late final SessionModel? _session;
  static EthPrivateKey? _ethPrivateKey;

  static String? ethAddress;
  static String? btcAddress;
  static String? solAddress;

  static bool isWalletLoaded = false;
  static bool isWalletConnected = false;
  static bool isSwitchingNetwork = false;
  static bool isRejected = false;

  static Future<void> init() async {
    loadWalletFromStorage();
    listenMessages();

    var listNetwork = await _networkData.getListNeworks();
    if (listNetwork.isNotEmpty) {
      final authApp = AuthAppController();
      await authApp.createListNetwork(listNetwork);
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
      printLog('All wallets loaded and accounts registered with WalletKit.');
    } else {
      isWalletLoaded = false;
      printLog('No wallet data found in storage.');
    }
  }

  // ETH Method
  static Future<dynamic> ethWalletConnect(
    String topic,
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

    final result = [_session?.eth?.walletAddress?.first];
    return result;
  }

  static Future<dynamic> ethChainId(
    String topic,
    dynamic params,
  ) async {
    if (isRejected) throw Exception('User rejected request');

    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();
    final chainId = network.chainId ?? "";

    return chainId.split(':').last;
  }

  static Future<dynamic> ethSign(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();
    final chainId = network.chainId ?? "";

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
      throw Exception('User rejected request');
    }

    final hexSignature = signMessageETH(
      mode: 'eth',
      message: message,
    );

    return hexSignature;
  }

  static Future<dynamic> personalSign(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();
    final chainId = network.chainId ?? '';

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
      throw Exception('User rejected request');
    }

    final hexSignature = signMessageETH(
      mode: 'eth',
      message: message,
    );

    return hexSignature;
  }

  static Future<dynamic> ethSignTransaction(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();
    final chainId = network.chainId ?? '';

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
      throw Exception('User rejected request');
    }

    final signedTx = await excTransactionETH(
      mode: 'sign',
      tx: tx,
      chainId: chainId,
    );

    return signedTx;
  }

  static Future<dynamic> ethSendTransaction(
    String topic,
    dynamic params,
  ) async {
    final authApp = AuthAppController();
    final network = authApp.getCurrentNetwork();
    final chainId = network.chainId ?? '';

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
      throw Exception('User rejected request');
    }

    final signedTx = await excTransactionETH(
      mode: 'send',
      tx: tx,
      chainId: chainId,
    );

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
      throw Exception('User rejected request');
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
    return null;
  }
}
