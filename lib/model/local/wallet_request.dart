import 'dart:convert';

import 'package:dompet_ku/service/enum/wallet.dart';
import 'package:dompet_ku/service/value/guard.dart';

class WalletRequestModel {
  String? chainId;
  String? address;
  String? message;
  String? data;
  String? value;
  List? params;
  WalletRequestType? type;

  WalletRequestModel({
    this.chainId,
    this.address,
    this.message,
    this.data,
    this.value,
    this.params,
    this.type,
  });

  WalletRequestModel.fromMap(Map<String, dynamic> map) {
    chainId = valueGuardian<String>(map['chainId']);
    address = valueGuardian<String>(map['address']);
    message = valueGuardian<String>(map['message']);
    data = valueGuardian<String>(map['data']);
    value = valueGuardian<String>(map['value']);
    params = valueGuardian<List>(map['params']);
    type = map['type'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['chainId'] = chainId;
    data['address'] = address;
    data['message'] = message;
    data['data'] = data;
    data['value'] = value;
    data['params'] = params;
    data['type'] = type;

    return data;
  }

  factory WalletRequestModel.fromJson(String source) {
    return WalletRequestModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
