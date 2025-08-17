import 'dart:convert';

import 'package:magicraft_wallet/service/value/guard.dart';
import 'package:flutter/material.dart';

class InfoPageModel {
  IconData? icon;
  String?   imageAsset;
  String?   title;
  String?   description;
  String?   buttonText;
  String?   route;

  InfoPageModel({
    this.icon,
    this.imageAsset,
    this.title,
    this.description,
    this.buttonText,
    this.route,
  });

  InfoPageModel.fromMap(Map<String, dynamic> map) {
    icon        = map['icon'];
    imageAsset  = valueGuardian<String>(map['imageAsset']);
    title       = valueGuardian<String>(map['title']);
    description = valueGuardian<String>(map['description']);
    buttonText  = valueGuardian<String>(map['buttonText']);
    route       = valueGuardian<String>(map['route']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['icon']        = icon;
    data['imageAsset']  = imageAsset;
    data['title']       = title;
    data['description'] = description;
    data['buttonText']  = buttonText;
    data['route']       = route;

    return data;
  }

  factory InfoPageModel.fromJson(String source) {
    return InfoPageModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
