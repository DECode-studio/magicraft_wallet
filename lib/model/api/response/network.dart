import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';

class NetworkModel {
  String? idNetwork;
  String? nameNetwork;
  String? chainId;
  String? networkScan;
  String? networkProvider;
  String? walletAddress;
  String? publicRPC;
  DateTime? createdNetwork;
  DateTime? updatedNetwork;

  NetworkModel({
    this.idNetwork,
    this.nameNetwork,
    this.chainId,
    this.networkScan,
    this.networkProvider,
    this.walletAddress,
    this.publicRPC,
    this.createdNetwork,
    this.updatedNetwork,
  });

  static List<NetworkModel> fromListMap(
    List listData,
  ) {
    final result = listData.map((e) => NetworkModel.fromMap(e)).toList();
    return result;
  }

  static List<NetworkModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result = listData.map((e) => NetworkModel.fromMap(e)).toList();
    return result;
  }

  factory NetworkModel.fromMap(Map<String, dynamic> map) {
    return NetworkModel(
      idNetwork: valueGuardian<String>(map['idNetwork']),
      nameNetwork: valueGuardian<String>(map['nameNetwork']),
      chainId: valueGuardian<String>(map['chainId']),
      networkScan: valueGuardian<String>(map['networkScan']),
      networkProvider: valueGuardian<String>(map['networkProvider']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
      publicRPC: valueGuardian<String>(map['publicRPC']),
      createdNetwork: valueGuardian<DateTime>(map['createdNetwork']),
      updatedNetwork: valueGuardian<DateTime>(map['updatedNetwork']),
    );
  }

  Map<String, dynamic> toMap() => {
        'idNetwork': idNetwork,
        'nameNetwork': nameNetwork,
        'chainId': chainId,
        'networkScan': networkScan,
        'networkProvider': networkProvider,
        'walletAddress': walletAddress,
        'publicRPC': publicRPC,
        'createdNetwork': createdNetwork?.toIso8601String(),
        'updatedNetwork': updatedNetwork?.toIso8601String(),
      };

  factory NetworkModel.fromJson(String source) {
    return NetworkModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
