import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class MintHistoryModel {
  String? idHistory;
  String? chainId;
  String? idToken;
  String? netType;
  String? tokenStandard;
  String? contractAddress;
  String? recipientAddress;
  String? walletAddress;
  String? metaData;
  DateTime? createdHistory;
  DateTime? updatedHistory;

  MintHistoryModel({
    this.idHistory,
    this.chainId,
    this.idToken,
    this.netType,
    this.tokenStandard,
    this.contractAddress,
    this.recipientAddress,
    this.walletAddress,
    this.metaData,
    this.createdHistory,
    this.updatedHistory,
  });

  static List<MintHistoryModel> fromListMap(
    List listData,
  ) {
    final result = listData.map((e) => MintHistoryModel.fromMap(e)).toList();
    return result;
  }

  static List<MintHistoryModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result = listData.map((e) => MintHistoryModel.fromMap(e)).toList();
    return result;
  }

  factory MintHistoryModel.fromMap(Map<String, dynamic> map) {
    return MintHistoryModel(
      idHistory: valueGuardian<String>(map['idHistory']),
      chainId: valueGuardian<String>(map['chainId']),
      idToken: valueGuardian<String>(map['idToken']),
      netType: valueGuardian<String>(map['netType']),
      tokenStandard: valueGuardian<String>(map['tokenStandard']),
      contractAddress: valueGuardian<String>(map['contractAddress']),
      recipientAddress: valueGuardian<String>(map['recipientAddress']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
      metaData: valueGuardian<String>(map['metaData']),
      createdHistory: valueGuardian<DateTime>(map['createdHistory']),
      updatedHistory: valueGuardian<DateTime>(map['updatedHistory']),
    );
  }

  Map<String, dynamic> toMap() => {
        'idHistory': idHistory,
        'chainId': chainId,
        'idToken': idToken,
        'netType': netType,
        'tokenStandard': tokenStandard,
        'contractAddress': contractAddress,
        'recipientAddress': recipientAddress,
        'walletAddress': walletAddress,
        'metaData': metaData,
        'createdHistory': createdHistory,
        'updatedHistory': updatedHistory,
      };

  factory MintHistoryModel.fromJson(String source) {
    return MintHistoryModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
