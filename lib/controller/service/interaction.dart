import 'dart:js' as js;
import 'dart:convert';

import 'package:magicraft_wallet/controller/service/wallet.dart';

void listenMessages() {
  js.context['onMessageFromExtension'] = (msg) async {
    try {
      final data = json.decode(msg);
      final method = data['method'];
      final params = data['params'];

      dynamic result;

      switch (method) {
        case "eth_accounts":
          result = await WalletAppController.ethAccounts("", params);
          break;
        case "eth_sign":
          result = await WalletAppController.ethSign("", params);
          break;
        case "personal_sign":
          result = await WalletAppController.personalSign("", params);
          break;
        case "eth_sendTransaction":
          result = await WalletAppController.ethSendTransaction("", params);
          break;
        case "wallet_switchEthereumChain":
          result =
              await WalletAppController.walletSwitchEthereumChain("", params);
          break;
        default:
          throw Exception("Method $method not implemented");
      }

      // kirim balik ke background
      js.context.callMethod("postMessageToBackground", [
        jsonEncode({"id": data['id'], "result": result})
      ]);
    } catch (e) {
      js.context.callMethod("postMessageToBackground", [
        jsonEncode({"id": msg['id'], "error": e.toString()})
      ]);
    }
  };
}
