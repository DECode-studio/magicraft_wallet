import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dompet_ku/service/value/guard.dart';

class DropdownModel {
  dynamic value;
  String? label;
  IconData? icon;
  Widget? item;

  DropdownModel({
    this.value,
    this.label,
    this.icon,
    this.item,
  });

  DropdownModel.fromMap(Map<String, dynamic> map) {
    value = map['value'];
    label = valueGuardian<String>(map['label']);
    icon = map['icon'];
    item = map['item'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    data['icon'] = icon;
    data['item'] = item;
    return data;
  }

  factory DropdownModel.fromJson(String source) {
    return DropdownModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
