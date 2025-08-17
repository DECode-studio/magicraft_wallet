import 'dart:convert';
import 'package:dompet_ku/service/value/guard.dart';

class EthSendTxRequest {
  int? chainId;
  String? contractAddress;
  String? to;
  int? gas;
  int? gasPrice;
  BigInt? value;
  String? data;
  int? nonce;

  EthSendTxRequest({
    this.chainId,
    this.contractAddress,
    this.to,
    this.gas,
    this.gasPrice,
    this.value,
    this.data,
    this.nonce,
  });

  EthSendTxRequest.fromMap(Map<String, dynamic> map) {
    chainId = valueGuardian<int>(map['chainId']);
    contractAddress = valueGuardian<String>(map['contractAddress']);
    to = valueGuardian<String>(map['to']);
    gas = valueGuardian<int>(map['gas']);
    gasPrice = valueGuardian<int>(map['gasPrice']);
    value = valueGuardian<BigInt>(map['value']);
    data = valueGuardian<String>(map['data']);
    nonce = valueGuardian<int>(map['nonce']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['chainId'] = chainId;
    map['contractAddress'] = contractAddress;
    map['to'] = to;
    map['gas'] = gas;
    map['gasPrice'] = gasPrice;
    map['value'] = value;
    map['data'] = data;
    map['nonce'] = nonce;

    return map;
  }

  factory EthSendTxRequest.fromJson(String source) {
    return EthSendTxRequest.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
