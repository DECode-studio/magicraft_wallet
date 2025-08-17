import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class GetNetworkRequest {
  String? walletAddress;

  GetNetworkRequest({
    this.walletAddress,
  });

  factory GetNetworkRequest.fromMap(Map<String, dynamic> map) {
    return GetNetworkRequest(
      walletAddress: valueGuardian<String>(map['walletAddress']),
    );
  }

  Map<String, dynamic> toMap() => {
        'walletAddress': walletAddress,
      };

  factory GetNetworkRequest.fromJson(String source) {
    return GetNetworkRequest.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class AddNetworkRequest {
  String? nameNetwork;
  String? chainId;
  String? networkRPC;
  String? networkScan;
  String? networkProvider;
  String? walletAddress;

  AddNetworkRequest({
    this.nameNetwork,
    this.chainId,
    this.networkRPC,
    this.networkScan,
    this.networkProvider,
    this.walletAddress,
  });

  factory AddNetworkRequest.fromMap(Map<String, dynamic> map) {
    return AddNetworkRequest(
      nameNetwork: valueGuardian<String>(map['nameNetwork']),
      chainId: valueGuardian<String>(map['chainId']),
      networkRPC: valueGuardian<String>(map['networkRPC']),
      networkScan: valueGuardian<String>(map['networkScan']),
      networkProvider: valueGuardian<String>(map['networkProvider']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
    );
  }

  Map<String, dynamic> toMap() => {
        'nameNetwork': nameNetwork,
        'chainId': chainId,
        'networkRPC': networkRPC,
        'networkScan': networkScan,
        'networkProvider': networkProvider,
        'walletAddress': walletAddress,
      };

  factory AddNetworkRequest.fromJson(String source) {
    return AddNetworkRequest.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
