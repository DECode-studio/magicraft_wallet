import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';

class AssetDetailModel {
  double? balance;
  String? symbol;
  int? decimals;
  String? chainId;
  List<AssetModel>? listData;

  AssetDetailModel({
    this.balance,
    this.symbol,
    this.decimals,
    this.chainId,
    this.listData,
  });

  factory AssetDetailModel.fromMap(Map<String, dynamic> map) {
    return AssetDetailModel(
      balance: valueGuardian<double>(map['balance']),
      symbol: valueGuardian<String>(map['symbol']),
      decimals: valueGuardian<int>(map['decimals']),
      chainId: valueGuardian<String>(map['chainId']),
      listData: AssetModel.fromListMap(map['listData']),
    );
  }

  Map<String, dynamic> toMap() => {
        'balance': balance,
        'symbol': symbol,
        'decimals': decimals,
        'chainId': chainId,
        'listData': listData?.map((e) => e.toMap()).toList(),
      };

  factory AssetDetailModel.fromJson(String source) {
    return AssetDetailModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class AssetModel {
  String? tokenLogo;
  String? tokenName;
  String? tokenSymbol;
  String? tokenAddress;
  String? tokenType;
  double? tokenBalance;
  int? tokenDecimals;

  AssetModel({
    this.tokenLogo,
    this.tokenName,
    this.tokenSymbol,
    this.tokenAddress,
    this.tokenType,
    this.tokenBalance,
    this.tokenDecimals,
  });

  static List<AssetModel> fromListMap(
    List listData,
  ) {
    final result = listData.map((e) => AssetModel.fromMap(e)).toList();
    return result;
  }

  static List<AssetModel> fromListJson(
    String data,
  ) {
    final listData = json.decode(data) as List;
    final result = listData.map((e) => AssetModel.fromMap(e)).toList();
    return result;
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      tokenLogo: valueGuardian<String>(map['tokenLogo']),
      tokenName: valueGuardian<String>(map['tokenName']),
      tokenSymbol: valueGuardian<String>(map['tokenSymbol']),
      tokenAddress: valueGuardian<String>(map['tokenAddress']),
      tokenType: valueGuardian<String>(map['tokenType']),
      tokenBalance: valueGuardian<double>(map['tokenBalance']),
      tokenDecimals: valueGuardian<int>(map['tokenDecimals']),
    );
  }

  Map<String, dynamic> toMap() => {
        'tokenLogo': tokenLogo,
        'tokenName': tokenName,
        'tokenSymbol': tokenSymbol,
        'tokenAddress': tokenAddress,
        'tokenType': tokenType,
        'tokenBalance': tokenBalance,
        'tokenDecimals': tokenDecimals,
      };

  factory AssetModel.fromJson(String source) {
    return AssetModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
