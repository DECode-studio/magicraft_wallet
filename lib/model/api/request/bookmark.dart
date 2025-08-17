import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';

class AddressBookmarkRequest {
  String? nameSpace;
  String? labelBookmark;
  String? walletAddress;

  AddressBookmarkRequest({
    this.nameSpace,
    this.labelBookmark,
    this.walletAddress,
  });

  factory AddressBookmarkRequest.fromMap(Map<String, dynamic> map) {
    return AddressBookmarkRequest(
      nameSpace: valueGuardian<String>(map['nameSpace']),
      labelBookmark: valueGuardian<String>(map['labelBookmark']),
      walletAddress: valueGuardian<String>(map['walletAddress']),
    );
  }

  Map<String, dynamic> toMap() => {
        'nameSpace': nameSpace,
        'labelBookmark': labelBookmark,
        'walletAddress': walletAddress,
      };

  factory AddressBookmarkRequest.fromJson(String source) {
    return AddressBookmarkRequest.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class UrlBookmarkRequest {
  String? labelBookmark;
  String? urlBookmark;

  UrlBookmarkRequest({
    this.labelBookmark,
    this.urlBookmark,
  });

  factory UrlBookmarkRequest.fromMap(Map<String, dynamic> map) {
    return UrlBookmarkRequest(
      labelBookmark: valueGuardian<String>(map['labelBookmark']),
      urlBookmark: valueGuardian<String>(map['urlBookmark']),
    );
  }

  Map<String, dynamic> toMap() => {
        'labelBookmark': labelBookmark,
        'urlBookmark': urlBookmark,
      };

  factory UrlBookmarkRequest.fromJson(String source) {
    return UrlBookmarkRequest.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
