import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';

class Web3ResultModel {
  String? id;
  String? dataHex;
  double? gassFee;
  String? currency;
  String? contractAddress;
  Map? meta;

  Web3ResultModel({
    this.id,
    this.dataHex,
    this.gassFee,
    this.currency,
    this.contractAddress,
    this.meta,
  });

  factory Web3ResultModel.fromMap(Map<String, dynamic> map) {
    return Web3ResultModel(
      id: valueGuardian<String>(map['id']),
      dataHex: valueGuardian<String>(map['dataHex']),
      gassFee: valueGuardian<double>(map['gassFee']),
      currency: valueGuardian<String>(map['currency']),
      contractAddress: valueGuardian<String>(map['contractAddress']),
      meta: valueGuardian<Map>(map['meta']),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'dataHex': dataHex,
        'gassFee': gassFee,
        'currency': currency,
        'contractAddress': contractAddress,
        'meta': meta,
      };

  factory Web3ResultModel.fromJson(String source) {
    return Web3ResultModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
