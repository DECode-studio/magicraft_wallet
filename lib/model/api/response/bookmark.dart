import 'dart:convert';

import 'package:dompet_ku/service/value/guard.dart';

class AddressBookmarkModel {
  String? idBookmark;
  String? ethAccount;
  String? nameSpace;
  String? labelBookmark;
  String? walletAddress;
  bool? statusBookmark;
  DateTime? createdBookmark;
  DateTime? updatedBookmark;

  AddressBookmarkModel({
    this.idBookmark,
    this.ethAccount,
    this.nameSpace,
    this.labelBookmark,
    this.walletAddress,
    this.statusBookmark,
    this.createdBookmark,
    this.updatedBookmark,
  });

  static List<AddressBookmarkModel> fromListMap(
    List listData,
  ) {
    final result =
        listData.map((e) => AddressBookmarkModel.fromMap(e)).toList();
    return result;
  }

  static List<AddressBookmarkModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result =
        listData.map((e) => AddressBookmarkModel.fromMap(e)).toList();
    return result;
  }

  factory AddressBookmarkModel.fromMap(Map<String, dynamic> map) {
    return AddressBookmarkModel(
      idBookmark: valueGuardian<String>(map['idBookmark']),
      ethAccount: valueGuardian<String>(map['ethAccount']),
      nameSpace: valueGuardian<String>(map['nameSpace']),
      labelBookmark: valueGuardian<String>(map['labelBookmark']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
      statusBookmark: valueGuardian<bool>(map['statusBookmark']),
      createdBookmark: valueGuardian<DateTime>(map['createdBookmark']),
      updatedBookmark: valueGuardian<DateTime>(map['updatedBookmark']),
    );
  }

  Map<String, dynamic> toMap() => {
        'idBookmark': idBookmark,
        'ethAccount': ethAccount,
        'nameSpace': nameSpace,
        'labelBookmark': labelBookmark,
        'walletAddress': walletAddress,
        'statusBookmark': statusBookmark,
        'createdBookmark': createdBookmark,
        'updatedBookmark': updatedBookmark,
      };

  factory AddressBookmarkModel.fromJson(String source) {
    return AddressBookmarkModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class UrlBookmarkModel {
  String? idBookmark;
  String? ethAccount;
  String? labelBookmark;
  String? urlBookmark;
  bool? statusBookmark;
  DateTime? createdBookmark;
  DateTime? updatedBookmark;

  UrlBookmarkModel({
    this.idBookmark,
    this.ethAccount,
    this.labelBookmark,
    this.urlBookmark,
    this.statusBookmark,
    this.createdBookmark,
    this.updatedBookmark,
  });

  static List<UrlBookmarkModel> fromListMap(
    List listData,
  ) {
    final result = listData.map((e) => UrlBookmarkModel.fromMap(e)).toList();
    return result;
  }

  static List<UrlBookmarkModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result = listData.map((e) => UrlBookmarkModel.fromMap(e)).toList();
    return result;
  }

  factory UrlBookmarkModel.fromMap(Map<String, dynamic> map) {
    return UrlBookmarkModel(
      idBookmark: valueGuardian<String>(map['idBookmark']),
      ethAccount: valueGuardian<String>(map['ethAccount']),
      labelBookmark: valueGuardian<String>(map['labelBookmark']),
      urlBookmark: valueGuardian<String>(map['urlBookmark']),
      statusBookmark: valueGuardian<bool>(map['statusBookmark']),
      createdBookmark: valueGuardian<DateTime>(map['createdBookmark']),
      updatedBookmark: valueGuardian<DateTime>(map['updatedBookmark']),
    );
  }

  Map<String, dynamic> toMap() => {
        'idBookmark': idBookmark,
        'ethAccount': ethAccount,
        'labelBookmark': labelBookmark,
        'urlBookmark': urlBookmark,
        'statusBookmark': statusBookmark,
        'createdBookmark': createdBookmark,
        'updatedBookmark': updatedBookmark,
      };

  factory UrlBookmarkModel.fromJson(String source) {
    return UrlBookmarkModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
