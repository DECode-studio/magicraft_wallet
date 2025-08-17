@JS()
library my_lib;

import 'dart:convert';
import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'package:js/js.dart';

import 'package:magicraft_wallet/controller/service/wallet.dart';
import 'package:magicraft_wallet/service/function/log.dart';

@JS('postMessageToBackground')
external void _postMessageToBackground(String message);

void listenMessages() {
  printLog(" - init wallet context");

  _notifyPopupReady();

  _registerJsonHandler();

  _registerWindowMessageHandler();

  printLog("✅ Flutter handlers registered");
}

void _notifyPopupReady() {
  try {
    js_util.callMethod(
      js_util.globalThis,
      'postMessage',
      [
        js_util.jsify({"source": "FLUTTER_WALLET_POPUP_READY"}),
        "*",
      ],
    );
    printLog(" - notifyPopupReady sent (via window.postMessage)");
  } catch (e, st) {
    printLog(' - error on notifyPopupReady : $e\n$st');
  }
}

void _registerJsonHandler() {
  try {
    js_util.setProperty(
      js_util.globalThis,
      'onMessageFromExtension',
      allowInterop((String msg) async {
        try {
          final data = json.decode(msg) as Map<String, dynamic>;
          await _handleRequestAndRespond(
            id: data['id'],
            method: data['method'],
            params: data['params'],
          );
        } catch (e, st) {
          printLog("❌ JSON handler error: $e\n$st");
          _safeRespondErrorTryBothChannels(id: _tryExtractId(msg), error: e);
        }
      }),
    );
    printLog("✅ onMessageFromExtension (JSON) registered");
  } catch (e, st) {
    printLog(' - error registering onMessageFromExtension : $e\n$st');
  }
}

void _registerWindowMessageHandler() {
  html.window.onMessage.listen((event) async {
    final data = event.data;
    if (data is Map && data['source'] == 'WALLET_REQUEST') {
      try {
        await _handleRequestAndRespond(
          id: data['id'],
          method: data['method'],
          params: data['params'],
        );
      } catch (e, st) {
        printLog("❌ window message handler error: $e\n$st");
        _safeRespondErrorTryBothChannels(id: data['id'], error: e);
      }
    }
  });
  printLog("✅ window.onMessage handler registered");
}

Future<void> _handleRequestAndRespond({
  required dynamic id,
  required String? method,
  required dynamic params,
}) async {
  printLog(' - incoming request : id=$id, method=$method, params=$params');

  if (method == null || method.isEmpty) {
    _safeRespondErrorTryBothChannels(
      id: id,
      error: 'Invalid method',
    );
    return;
  }

  try {
    dynamic result;

    switch (method) {
      case 'eth_accounts' || 'eth_requestAccounts':
        result = await WalletAppController.ethAccounts("", params);
        break;

      case "eth_chainId":
        result = await WalletAppController.ethChainId("", params);
        break;

      case 'wallet_requestPermissions' ||
            'wallet_getPermissions' ||
            'wallet_revokePermissions':
        result = await WalletAppController.ethWalletConnect("", params);
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

    printLog(" - method result : $result");
    _respondSuccessTryBothChannels(id: id, result: result);
  } catch (e, st) {
    printLog("❌ handleRequest error: $e\n$st");
    _safeRespondErrorTryBothChannels(id: id, error: e);
  }
}

void _respondSuccessTryBothChannels(
    {required dynamic id, required dynamic result}) {
  try {
    js_util.callMethod(
      js_util.globalThis,
      'postMessage',
      [
        js_util.jsify({
          "source": "FLUTTER_WALLET_RESPONSE",
          "id": id,
          "result": result,
        }),
        "*",
      ],
    );
  } catch (_) {}

  try {
    _postMessageToBackground(json
        .encode({"type": "wallet_popup_response", "id": id, "result": result}));
  } catch (_) {}
}

void _safeRespondErrorTryBothChannels(
    {required dynamic id, required Object error}) {
  final errStr = error.toString();

  try {
    js_util.callMethod(
      js_util.globalThis,
      'postMessage',
      [
        js_util.jsify({
          "source": "FLUTTER_WALLET_RESPONSE",
          "id": id,
          "error": errStr,
        }),
        "*",
      ],
    );
  } catch (_) {}

  try {
    _postMessageToBackground(json
        .encode({"type": "wallet_popup_response", "id": id, "error": errStr}));
  } catch (_) {}
}

dynamic _tryExtractId(String raw) {
  try {
    final m = json.decode(raw);
    if (m is Map && m.containsKey('id')) return m['id'];
  } catch (_) {}
  return null;
}
