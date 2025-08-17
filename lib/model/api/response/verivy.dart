import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class VerifyModel {
  String? token;

  VerifyModel({
    this.token,
  });

  factory VerifyModel.fromMap(Map<String, dynamic> map) {
    return VerifyModel(
      token: valueGuardian<String>(map['token']),
    );
  }

  Map<String, dynamic> toMap() => {
        'token': token,
      };

  factory VerifyModel.fromJson(String source) {
    return VerifyModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
