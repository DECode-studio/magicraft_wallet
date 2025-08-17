import 'dart:convert';
import 'dart:typed_data';

import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/service/function/log.dart';
import 'package:dompet_ku/service/value/encrypt.dart';
import 'package:dompet_ku/service/value/guard.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:web3dart/crypto.dart';

Future<void> errWallerNotLoaded(
  ReownWalletKit walletKit,
  String topic,
) async {
  final session = AuthAppController.getSession();

  if (session.eth?.publicKey == null || session.eth?.privateKey == null) {
    final res = JsonRpcResponse(
      id: 0,
      error: JsonRpcError(
        code: -32000,
        message: 'Ethereum wallet not loaded.',
      ),
    );

    return await walletKit.respondSessionRequest(
      topic: topic,
      response: res,
    );
  }
}

Future<bool> switchChainETH({
  required String chainId,
}) async {
  final authApp = AuthAppController();
  final listNetwork = await authApp.getListNetwork();
  final networks = listNetwork.where((e) => e.chainId == chainId).toList();

  if (networks.isNotEmpty) {
    await authApp.createLocalNetwork(data: networks.first);
    return true;
  } else {
    return false;
  }
}

String signMessageETH({
  required String mode,
  required String message,
}) {
  final session = AuthAppController.getSession();
  final encrypt = EncryptValue();
  final credentials = EthPrivateKey.fromHex(
    encrypt.decryptData(session.eth?.privateKey ?? ''),
  );

  if (mode == 'personal') {
    final prefix = "\u0019Ethereum Signed Message:\n${message.length}";
    final prefixedMessage = utf8.encode(prefix) + utf8.encode(message);
    final messageHash = keccak256(Uint8List.fromList(prefixedMessage));

    final signature = credentials.signToUint8List(
      messageHash,
      chainId: null,
    );

    final hexSignature = '0x${bytesToHex(
      signature.toList(),
      include0x: false,
    )}';

    return hexSignature;
  }

  if (mode == 'eth') {
    final messageBytes = Uint8List.fromList(message.codeUnits);
    final signature = credentials.signPersonalMessageToUint8List(messageBytes);
    final hexSignature = '0x${HEX.encode(signature)}';

    return hexSignature;
  }

  return '';
}

String encodeErc20Transfer({
  required String toAddress,
  required BigInt amount,
}) {
  final cleanAddress = toAddress.replaceAll('0x', '').toLowerCase();
  final functionSelector = 'a9059cbb';
  final addressPadded = cleanAddress.padLeft(64, '0');
  final amountHex = amount.toRadixString(16).padLeft(64, '0');

  return '0x$functionSelector$addressPadded$amountHex';
}

Future<String> excTransactionETH({
  required String mode,
  required Map<String, dynamic> tx,
  required String chainId,
}) async {
  final authApp = AuthAppController();
  final encrypt = EncryptValue();
  final session = AuthAppController.getSession();

  final walletAddress = session.eth?.walletAddress?.first;
  final credentials = EthPrivateKey.fromHex(
    encrypt.decryptData(session.eth?.privateKey ?? ''),
  );

  final chainIdX = valueGuardian<int>(tx['chainId']);
  final to = valueGuardian<String>(tx['to']);
  printLog(chainIdX);

  final network = await authApp.getNetwork(chainId);
  final client = Web3Client(
    network.publicRPC ?? '',
    Client(),
  );

  final gasLimit = valueGuardian<int>(tx['gas']) ?? 100000;
  final gasPrice = tx['gasPrice'] != null
      ? EtherAmount.inWei(BigInt.parse(tx['gasPrice'].toString()))
      : await client.getGasPrice();

  final value =
      tx['value'] != null ? EtherAmount.inWei(tx['value']) : EtherAmount.zero();
  final data = tx['data'] != null ? hexToBytes(tx['data'].toString()) : <int>[];
  final nonce = valueGuardian<int>(tx['nonce'].toString()) ??
      await client.getTransactionCount(
        EthereumAddress.fromHex(walletAddress),
      );

  final transaction = Transaction(
    from: EthereumAddress.fromHex(walletAddress),
    to: EthereumAddress.fromHex(to ?? ''),
    gasPrice: gasPrice,
    maxGas: gasLimit,
    value: value,
    nonce: nonce,
    data: Uint8List.fromList(data),
  );

  if (mode == 'sign') {
    final sign = await client.signTransaction(
      credentials,
      transaction,
      chainId: int.parse(chainId.split(":").last),
    );

    return HEX.encode(sign.toList());
  }

  if (mode == 'send') {
    return await client.sendTransaction(
      credentials,
      transaction,
      chainId: int.parse(chainId.split(":").last),
    );
  }

  return '';
}
