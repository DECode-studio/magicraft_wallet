import 'dart:convert';

import 'package:dompet_ku/model/api/response/network.dart';
import 'package:dompet_ku/service/value/guard.dart';

class LocalNetworkModel {
  String? network;
  String? chainId;
  String? walletAddress;
  NetworkModel? detail;

  LocalNetworkModel({
    this.network,
    this.chainId,
    this.walletAddress,
    this.detail,
  });

  LocalNetworkModel.fromMap(Map<String, dynamic> map) {
    network = valueGuardian<String>(map['network']);
    chainId = valueGuardian<String>(map['chainId']);
    walletAddress = valueGuardian<String>(map['walletAddress']);
    detail = NetworkModel.fromMap(map['detail']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['network'] = network;
    data['chainId'] = chainId;
    data['walletAddress'] = walletAddress;
    data['detail'] = detail?.toMap();

    return data;
  }

  factory LocalNetworkModel.fromJson(String source) {
    return LocalNetworkModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class SessionModel {
  String? seedPhrase;
  String? password;
  String? token;
  WalletModel? eth;

  SessionModel({
    this.seedPhrase,
    this.password,
    this.token,
    this.eth,
  });

  SessionModel.fromMap(Map<String, dynamic> map) {
    seedPhrase = valueGuardian<String>(map['seedPhrase']);
    password = valueGuardian<String>(map['password']);
    token = valueGuardian<String>(map['token']);
    eth = WalletModel.fromMap(map['eth']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['seedPhrase'] = seedPhrase;
    data['password'] = password;
    data['token'] = token;
    data['eth'] = eth?.toMap();

    return data;
  }

  factory SessionModel.fromJson(String source) {
    return SessionModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class WalletModel {
  String? privateKey;
  String? publicKey;
  List? walletAddress;

  WalletModel({
    this.privateKey,
    this.publicKey,
    this.walletAddress,
  });

  WalletModel.fromMap(Map<String, dynamic> map) {
    privateKey = valueGuardian<String>(map['privateKey']);
    publicKey = valueGuardian<String>(map['publicKey']);
    walletAddress = map['walletAddress'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['privateKey'] = privateKey;
    data['publicKey'] = publicKey;
    data['walletAddress'] = walletAddress;

    return data;
  }

  factory WalletModel.fromJson(String source) {
    return WalletModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
