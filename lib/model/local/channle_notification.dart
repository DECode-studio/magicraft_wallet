import 'dart:convert';
import 'package:dompet_ku/service/value/guard.dart';

class ChannelNotificationLocalModel {
  String? idChannel;
  String? nameChannel;
  String? descChannel;
  Map? data;

  ChannelNotificationLocalModel({
    this.idChannel,
    this.nameChannel,
    this.descChannel,
    this.data,
  });

  ChannelNotificationLocalModel.fromMap(Map<String, dynamic> map) {
    idChannel = valueGuardian<String>(map['idChannel']);
    nameChannel = valueGuardian<String>(map['nameChannel']);
    descChannel = valueGuardian<String>(map['descChannel']);
    data = valueGuardian<Map>(map['data']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['idChannel'] = idChannel;
    data['nameChannel'] = nameChannel;
    data['descChannel'] = descChannel;
    data['data'] = data;

    return data;
  }

  factory ChannelNotificationLocalModel.fromJson(String source) {
    return ChannelNotificationLocalModel.fromMap(
      Map<String, dynamic>.from(json.decode(source)),
    );
  }

  String toJson() => json.encode(toMap());
}
