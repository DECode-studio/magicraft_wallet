import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';
import 'package:universal_io/io.dart';

class MintErc721Request {
  String? chainId;
  String? netType;
  String? name;
  String? recipientAddress;
  String? description;
  String? attribute;
  File? file;
  File? fileDocument;

  MintErc721Request({
    this.chainId,
    this.netType,
    this.name,
    this.recipientAddress,
    this.description,
    this.attribute,
    this.file,
    this.fileDocument,
  });

  factory MintErc721Request.fromMap(Map<String, dynamic> map) {
    return MintErc721Request(
      chainId: valueGuardian<String>(map['chainId']),
      netType: valueGuardian<String>(map['netType']),
      name: valueGuardian<String>(map['name']),
      recipientAddress: valueGuardian<String>(map['recipientAddress']),
      description: valueGuardian<String>(map['description']),
      attribute: valueGuardian<String>(map['attribute']),
      file: map['file'],
      fileDocument: map['fileDocument'],
    );
  }

  Map<String, dynamic> toMap() => {
        'chainId': chainId,
        'netType': netType,
        'name': name,
        'recipientAddress': recipientAddress,
        'description': description,
        'attribute': attribute,
        'file': file,
        'fileDocument': fileDocument,
      };

  factory MintErc721Request.fromJson(String source) {
    return MintErc721Request.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
