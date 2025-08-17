import 'dart:convert';

import 'package:flutter/material.dart';

class BottomBarItemModel {
  late IconData selectedIcon;
  late IconData unSelectedIcon;
  late String textMenu;

  BottomBarItemModel({
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.textMenu,
  });

  BottomBarItemModel.fromMap(Map<String, dynamic> json) {
    selectedIcon = json['selectedIcon'];
    unSelectedIcon = json['unSelectedIcon'];
    textMenu = json['textMenu'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['selectedIcon'] = selectedIcon;
    data['unSelectedIcon'] = unSelectedIcon;
    data['textMenu'] = textMenu;

    return data;
  }

  factory BottomBarItemModel.fromJson(String source) {
    return BottomBarItemModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}

class GridMenuItemModel {
  late IconData iconMenu;
  late String textMenu;
  late String actionMethod;

  GridMenuItemModel({
    required this.iconMenu,
    required this.textMenu,
    required this.actionMethod,
  });

  GridMenuItemModel.fromMap(Map<String, dynamic> json) {
    iconMenu = json['iconMenu'];
    textMenu = json['textMenu'];
    actionMethod = json['actionMethod'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['iconMenu'] = iconMenu;
    data['textMenu'] = textMenu;
    data['actionMethod'] = actionMethod;

    return data;
  }

  factory GridMenuItemModel.fromJson(String source) {
    return GridMenuItemModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
