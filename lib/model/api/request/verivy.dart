import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class VerifyRequest {
  String? chain;
  String? walletAddress;
  String? message;
  String? signature;
  String? publicKey;

  VerifyRequest({
    this.chain,
    this.walletAddress,
    this.message,
    this.signature,
    this.publicKey,
  });

  factory VerifyRequest.fromMap(Map<String, dynamic> map) {
    return VerifyRequest(
      chain: valueGuardian<String>(map['chain']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
      message: valueGuardian<String>(map['message']),
      signature: valueGuardian<String>(map['signature']),
      publicKey: valueGuardian<String>(map['publicKey']),
    );
  }

  Map<String, dynamic> toMap() => {
        'chain': chain,
        'walletAddress': walletAddress,
        'message': message,
        'signature': signature,
        'publicKey': publicKey,
      };

  factory VerifyRequest.fromJson(String source) {
    return VerifyRequest.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}