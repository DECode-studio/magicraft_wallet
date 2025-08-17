import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';

class BrowserHistoryModel {
  String? idHistory;
  String? thumbnailPage;
  String? namePage;
  String? urlPage;
  DateTime? createData;

  BrowserHistoryModel({
    this.idHistory,
    this.thumbnailPage,
    this.namePage,
    this.urlPage,
    this.createData,
  });

  static List<BrowserHistoryModel> fromListMap(
    List listData,
  ) {
    final result = listData.map((e) => BrowserHistoryModel.fromMap(e)).toList();
    return result;
  }

  static List<BrowserHistoryModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result = listData.map((e) => BrowserHistoryModel.fromMap(e)).toList();
    return result;
  }

  factory BrowserHistoryModel.fromMap(Map<String, dynamic> map) {
    return BrowserHistoryModel(
      idHistory: valueGuardian<String>(map['idHistory']),
      thumbnailPage: valueGuardian<String>(map['thumbnailPage']),
      namePage: valueGuardian<String>(map['namePage']),
      urlPage: valueGuardian<String>(map['urlPage']),
      createData: valueGuardian<DateTime>(map['createData']),
    );
  }

  Map<String, dynamic> toMap() => {
        'idHistory': idHistory,
        'thumbnailPage': thumbnailPage,
        'namePage': namePage,
        'urlPage': urlPage,
        'createData': createData?.toIso8601String(),
      };

  factory BrowserHistoryModel.fromJson(String source) {
    return BrowserHistoryModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
