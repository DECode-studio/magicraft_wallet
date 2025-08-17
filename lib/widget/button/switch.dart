import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget switchButton({
  required bool initData,
  required Function(bool) onChange,
  String? data,
  IconData? icon,
  Color? color,
  TextStyle? dataStyle,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          overlayColor: color == null ? null : WidgetStateProperty.all(color),
          thumbIcon: icon == null
              ? null
              : WidgetStateProperty.all(
                  Icon(icon),
                ),
          value: initData,
          onChanged: onChange,
        ),
        data == null
            ? Container()
            : const SizedBox(
                width: 15,
              ),
        data == null
            ? Container()
            : Expanded(
                child: Text(
                  data,
                  style: dataStyle ?? bold_12_1,
                ),
              ),
      ],
    );

Widget titleSwitchButton({
  required String title,
  required bool initData,
  required Function(bool) onChange,
  String? data,
  IconData? icon,
  Color? color,
  TextStyle? titleStyle,
  TextStyle? dataStyle,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? bold_12_1,
        ),
        const SizedBox(
          height: 10,
        ),
        switchButton(
          data: data,
          icon: icon,
          color: color,
          dataStyle: dataStyle,
          initData: initData,
          onChange: onChange,
        ),
      ],
    );
