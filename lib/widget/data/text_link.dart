import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dompet_ku/style/text.dart';

Widget textLink({
  required Function() onClick,
  required String text,
  required String link,
  TextStyle? textStyle,
  TextStyle? linkStyle,
}) =>
    RichText(
      text: TextSpan(
        text: text,
        style: textStyle ?? normal_12_1,
        children: [
          TextSpan(
            text: link,
            style: linkStyle ?? normal_12_4,
            recognizer: TapGestureRecognizer()..onTap = onClick,
          ),
        ],
      ),
    );
