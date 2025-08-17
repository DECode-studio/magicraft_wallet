import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class NetworkProviderModel {
  String? idProvider;
  String? nameProvider;
  String? urlProvider;
  DateTime? createdProvider;
  DateTime? updatedProvider;

  NetworkProviderModel({
    this.idProvider,
    this.nameProvider,
    this.urlProvider,
    this.createdProvider,
    this.updatedProvider,
  });

  static List<NetworkProviderModel> fromListMap(
    List listData,
  ) {
    final result =
        listData.map((e) => NetworkProviderModel.fromMap(e)).toList();
    return result;
  }

  static List<NetworkProviderModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result =
        listData.map((e) => NetworkProviderModel.fromMap(e)).toList();
    return result;
  }

  factory NetworkProviderModel.fromMap(Map<String, dynamic> map) {
    return NetworkProviderModel(
      idProvider: valueGuardian<String>(map['idProvider']),
      nameProvider: valueGuardian<String>(map['nameProvider']),
      urlProvider: valueGuardian<String>(map['urlProvider']),
      createdProvider: valueGuardian<DateTime>(map['createdProvider']),
      updatedProvider: valueGuardian<DateTime>(map['updatedProvider']),
    );
  }

  Map<String, dynamic> toMap() => {
        'idProvider': idProvider,
        'nameProvider': nameProvider,
        'urlProvider': urlProvider,
        'createdProvider': createdProvider,
        'updatedProvider': updatedProvider,
      };

  factory NetworkProviderModel.fromJson(String source) {
    return NetworkProviderModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
