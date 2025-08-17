import 'dart:convert';
import 'package:dompet_ku/service/value/guard.dart';

class ApiResponse<T> {
  StatusModel? status;
  MetaModel? meta;
  T? data;

  ApiResponse({
    this.status,
    this.meta,
    this.data,
  });

  factory ApiResponse.fromMap({
    required Map<String, dynamic> data,
    Function(Map<String, dynamic>)? fromData,
  }) {
    return ApiResponse(
      status:
          data['status'] != null ? StatusModel.fromMap(data['status']) : null,
      meta: data['meta'] != null ? MetaModel.fromMap(data['meta']) : null,
      data: fromData == null ? null : fromData(data['data']),
    );
  }

  factory ApiResponse.fromJson({
    required String data,
    Function(String)? fromData,
  }) {
    Map<String, dynamic> map = json.decode(data);
    final result = map['data'];

    return ApiResponse(
      status: map['status'] != null ? StatusModel.fromMap(map['status']) : null,
      meta: map['meta'] != null ? MetaModel.fromMap(map['meta']) : null,
      data: fromData == null ? null : fromData(json.encode(result)),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status?.toMap(),
        'data': data,
        'meta': meta?.toMap(),
      };

  String toJson() => json.encode(toMap());
}

class StatusModel {
  int? code;
  String? message;

  StatusModel({
    this.code,
    this.message,
  });

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      code: valueGuardian<int>(map['code']),
      message: valueGuardian<String>(map['message']),
    );
  }

  Map<String, dynamic> toMap() => {
        'code': code,
        'message': message,
      };

  factory StatusModel.fromJson(String source) {
    return StatusModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class MetaModel {
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  int? total;
  int? perPage;

  MetaModel({
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
    this.total,
    this.perPage,
  });

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      currentPage: valueGuardian<int>(map['current_page']),
      lastPage: valueGuardian<int>(map['last_page']),
      from: valueGuardian<int>(map['from']),
      to: valueGuardian<int>(map['to']),
      total: valueGuardian<int>(map['total']),
      perPage: valueGuardian<int>(map['per_page']),
    );
  }

  Map<String, dynamic> toMap() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'from': from,
        'to': to,
        'total': total,
        'per_page': perPage,
      };

  factory MetaModel.fromJson(String source) {
    return MetaModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
