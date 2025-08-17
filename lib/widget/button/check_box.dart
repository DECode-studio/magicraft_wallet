import 'package:flutter/gestures.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';

Widget checkBox({
  required Function(bool) onChange,
  required bool value,
  required String text,
  TextStyle? textStyle,
  IconData? checkedIcon,
  IconData? unCheckedIcon,
  Color? activeColor,
  Color? unActiveColor,
  double? iconSize,
  String? linkText,
  TextStyle? linkStyle,
  Function()? onLinkClicked,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onChange(!value),
          child: Icon(
            value
                ? checkedIcon ?? HugeIcons.strokeRoundedCheckmarkSquare03
                : unCheckedIcon ?? HugeIcons.strokeRoundedSquare,
            color: value
                ? (activeColor ?? mainColor_1)
                : (unActiveColor ?? gray_2),
            size: iconSize,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textStyle ?? normal_15_2,
              children: [
                TextSpan(
                  text: text,
                  style: textStyle ?? normal_15_2,
                ),
                if (linkText != null)
                  TextSpan(
                    text: linkText,
                    style: linkStyle ??
                        normal_15_5(
                          color: mainColor_1,
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()..onTap = onLinkClicked,
                  ),
              ],
            ),
          ),
        ),
      ],
    );

Widget checkBoxTitle({
  required String title,
  required Function(bool) onChange,
  required bool value,
  required String text,
  TextStyle? textStyle,
  TextStyle? titleStyle,
  IconData? checkedIcon,
  IconData? unCheckedIcon,
  Color? activeColor,
  Color? unActiveColor,
  double? iconSize,
  String? linkText,
  TextStyle? linkStyle,
  Function()? onLinkClicked,
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
        checkBox(
          onChange: onChange,
          value: value,
          text: text,
          textStyle: textStyle,
          checkedIcon: checkedIcon,
          unCheckedIcon: unCheckedIcon,
          activeColor: activeColor,
          unActiveColor: unActiveColor,
          iconSize: iconSize,
          linkText: linkText,
          linkStyle: linkStyle,
          onLinkClicked: onLinkClicked,
        ),
      ],
    );
