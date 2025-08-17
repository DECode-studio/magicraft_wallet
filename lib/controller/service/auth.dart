import 'dart:async';
import 'dart:convert';

import 'package:dompet_ku/model/api/response/network.dart';
import 'package:dompet_ku/model/local/session.dart';
import 'package:dompet_ku/service/function/log.dart';
import 'package:dompet_ku/service/value/encrypt.dart';
import 'package:get_storage/get_storage.dart';

class AuthAppController {
  static final _storage = GetStorage();
  static final _encrypt = EncryptValue();

  static final _key = 'session';
  static final _keyNetwork = 'network';
  static final _keyListNetwork = 'list_network';

  Stream<LocalNetworkModel> streamCurrentNetwork() {
    final controller = StreamController<LocalNetworkModel>.broadcast();
    controller.add(getCurrentNetwork());

    _storage.listenKey(_keyNetwork, (value) {
      controller.add(getCurrentNetwork(data: value));
    });

    return controller.stream;
  }

  LocalNetworkModel getCurrentNetwork({
    String? data,
  }) {
    var network = LocalNetworkModel();

    try {
      final encryptedData = data ?? _storage.read<String>(_keyNetwork) ?? '{}';
      final jsonStr = _encrypt.decryptData(encryptedData);
      final jsonMap = json.decode(jsonStr);

      network = LocalNetworkModel.fromMap(jsonMap);
    } catch (e) {
      printLog('Get Local Network Error: $e');
    }
    return network;
  }

  Future<void> createLocalNetwork({
    NetworkModel? data,
  }) async {
    try {
      final session = getSession();

      var network = 'eth';
      var chainId = 'eip155:1';
      var walletAddress = session.eth?.walletAddress?[0] ?? '';

      if (data != null) {
        chainId = data.chainId ?? '';

        if (chainId.split(":").first == "eip155") {
          network = "eth";
          walletAddress = session.eth?.walletAddress?[0] ?? '';
        }
      }

      final dataNetwork = LocalNetworkModel(
        network: network,
        chainId: chainId,
        walletAddress: walletAddress,
        detail: data ??
            NetworkModel(
              nameNetwork: "Ethereum Mainnet",
              chainId: 'eip155:1',
              networkScan: "https://etherscan.io",
              networkProvider: "alchemy",
            ),
      );

      final encryptedSession = _encrypt.encryptData(dataNetwork.toJson());
      await _storage.write(_keyNetwork, encryptedSession);
    } catch (e) {
      printLog('Create Local Network Error: $e');
    }
  }

  static SessionModel getSession() {
    var session = SessionModel();

    try {
      final encryptedData = _storage.read<String>(_key) ?? '{}';
      final jsonStr = _encrypt.decryptData(encryptedData);
      final jsonMap = json.decode(jsonStr);

      session = SessionModel.fromMap(jsonMap);
    } catch (e) {
      printLog('Get Session Error: $e');
    }
    return session;
  }

  Future<bool> createSession(
    String sessionJson,
  ) async {
    try {
      final encryptedSession = _encrypt.encryptData(sessionJson);

      await _storage.write(_key, encryptedSession);
      await createLocalNetwork();

      return true;
    } catch (e) {
      printLog('Create Session Error: $e');
      return false;
    }
  }

  Future<List<NetworkModel>> getListNetwork() async {
    var listData = <NetworkModel>[];

    try {
      final encryptedData = _storage.read<String>(_keyListNetwork) ?? '[]';
      final jsonStr = _encrypt.decryptData(encryptedData);
      final jsonMap = json.decode(jsonStr);

      listData = NetworkModel.fromListMap(jsonMap);
    } catch (e) {
      printLog('Get List Network Error: $e');
    }

    return listData;
  }

  Future<NetworkModel> getNetwork(
    String chainId,
  ) async {
    final listData = await getListNetwork();

    try {
      var networks = listData.where((e) => e.chainId == chainId).toList();

      if (networks.isNotEmpty) {
        return networks.first;
      } else {
        printLog('Get List Network Empty');
        return NetworkModel();
      }
    } catch (e) {
      printLog('Get List Network Error: $e');
      return NetworkModel();
    }
  }

  Future<void> createListNetwork(
    List<NetworkModel> listData,
  ) async {
    try {
      final networks = listData.map((e) => e.toMap()).toList();
      final jsonNetworks = json.encode(networks);
      final encryptedNetworks = _encrypt.encryptData(jsonNetworks);

      await _storage.write(_keyListNetwork, encryptedNetworks);
    } catch (e) {
      printLog('Create List Network Error: $e');
    }
  }

  Future<void> clearSession() async {
    try {
      await _storage.remove(_key);
      await _storage.remove(_keyNetwork);
      await _storage.remove(_keyListNetwork);
      printLog('Session cleared from storage.');
    } catch (e) {
      printLog('Error clearing session: $e');
    }
  }

  bool isJwtExpired({
    String? injectedToken,
  }) {
    try {
      final session = getSession();
      final token = injectedToken ?? _encrypt.decryptData(session.token ?? '');
      final parts = token.split('.');

      if (parts.length != 3) {
        throw const FormatException('Invalid JWT token');
      }

      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final payloadMap = json.decode(payload) as Map<String, dynamic>;

      if (!payloadMap.containsKey('exp')) {
        throw const FormatException('JWT does not contain exp');
      }

      final exp = payloadMap['exp'] as int;
      final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final result = nowInSeconds >= exp;

      return result;
    } catch (_) {
      return true;
    }
  }
}
