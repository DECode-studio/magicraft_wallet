import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class Web3Request {
  String? chainId;
  String? walletAddress;
  String? contractAddress;

  Web3Request({
    this.chainId,
    this.walletAddress,
    this.contractAddress,
  });

  factory Web3Request.fromMap(Map<String, dynamic> map) {
    return Web3Request(
      chainId: valueGuardian<String>(map['chainId']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
      contractAddress: valueGuardian<String>(map['contractAddress']),
    );
  }

  Map<String, dynamic> toMap() => {
        'chainId': chainId,
        'walletAddress': walletAddress,
        'contractAddress': contractAddress,
      };

  factory Web3Request.fromJson(String source) {
    return Web3Request.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}