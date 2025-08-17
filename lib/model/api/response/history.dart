import 'dart:convert';
import 'package:magicraft_wallet/service/value/guard.dart';

class TransactionHistoryModel {
  String? hash;
  String? network;
  int? block;
  int? timestamp;
  String? from;
  String? to;
  int? value;
  String? asset;
  String? direction;

  TransactionHistoryModel({
    this.hash,
    this.network,
    this.block,
    this.timestamp,
    this.from,
    this.to,
    this.value,
    this.asset,
    this.direction,
  });

  static List<TransactionHistoryModel> fromListMap(List listData) {
    final result =
        listData.map((e) => TransactionHistoryModel.fromMap(e)).toList();
    return result;
  }

  static List<TransactionHistoryModel> fromListJson(String data) {
    final listData = json.decode(data) as List;
    final result =
        listData.map((e) => TransactionHistoryModel.fromMap(e)).toList();
    return result;
  }

  factory TransactionHistoryModel.fromMap(Map<String, dynamic> map) {
    return TransactionHistoryModel(
      hash: valueGuardian<String>(map['hash']),
      network: valueGuardian<String>(map['network']),
      block: valueGuardian<int>(map['block']),
      timestamp: valueGuardian<int>(map['timestamp']),
      from: valueGuardian<String>(map['from']),
      to: valueGuardian<String>(map['to']),
      value: valueGuardian<int>(map['value']),
      asset: valueGuardian<String>(map['asset']),
      direction: valueGuardian<String>(map['direction']),
    );
  }

  Map<String, dynamic> toMap() => {
        'hash': hash,
        'network': network,
        'block': block,
        'timestamp': timestamp,
        'from': from,
        'to': to,
        'value': value,
        'asset': asset,
        'direction': direction,
      };

  factory TransactionHistoryModel.fromJson(String source) {
    return TransactionHistoryModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
