import 'dart:convert';
import 'package:magicraft_wallet/service/value/guard.dart';

class StepperDocumentModel {
  int? index;
  String? label;
  String? description;
  bool? status;

  StepperDocumentModel({
    this.index,
    this.label,
    this.description,
    this.status,
  });

  StepperDocumentModel.fromMap(Map<String, dynamic> map) {
    index = valueGuardian<int>(map['index']);
    label = valueGuardian<String>(map['label']);
    description = valueGuardian<String>(map['description']);
    status = valueGuardian<bool>(map['status']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['label'] = label;
    data['description'] = description;
    data['status'] = status;
    return data;
  }

  factory StepperDocumentModel.fromJson(String source) {
    return StepperDocumentModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
