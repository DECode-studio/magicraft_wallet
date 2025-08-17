import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/style/text_box.dart';

Widget textBox({
  required TextEditingController textController,
  required TextInputType inputType,
  required String hint,
  IconData? icon,
  List<Widget>? actions,
  int? lines,
  int? minLine,
  Function()? onTap,
  Function(String value)? onChange,
  Function(String value)? onSubmit,
  Function(PointerDownEvent)? onTapOutside,
  FocusNode? focusNode,
  bool? readOnly,
  List<TextInputFormatter>? inputFormatters,
  Color? backColor,
  Color? borderColor,
  Color? hintColor,
  double? radiusSize,
  TextStyle? textStyle,
  TextStyle? hintStyle,
}) =>
    Container(
      decoration: customRoundedStyle(
        color: backColor ?? gray_3,
        size: radiusSize ?? 15,
      ),
      child: TextField(
        controller: textController,
        keyboardType: inputType,
        readOnly: readOnly ?? false,
        decoration: textFieldStyle(
          hint: hint,
          icon: icon,
          borderColor: borderColor,
          hintColor: hintColor,
          radiusSize: radiusSize,
          suffix: actions == null
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: actions,
                ),
        ),
        maxLines: lines ?? 1,
        minLines: minLine ?? lines ?? 1,
        onChanged: onChange,
        onSubmitted: onSubmit,
        onTap: onTap,
        onTapOutside: onTapOutside,
        inputFormatters: inputFormatters,
        style: textStyle,
      ),
    );

Widget textBoxTitle({
  required TextEditingController textController,
  required TextInputType inputType,
  required String title,
  required String hint,
  IconData? icon,
  List<Widget>? actions,
  int? lines,
  int? minLine,
  Function()? onTap,
  Function(String value)? onChange,
  Function(String value)? onSubmit,
  Function(PointerDownEvent)? onTapOutside,
  FocusNode? focusNode,
  bool? readOnly,
  List<TextInputFormatter>? inputFormatters,
  Color? backColor,
  Color? borderColor,
  Color? hintColor,
  double? radiusSize,
  TextStyle? titleStyle,
  TextStyle? textStyle,
  TextStyle? hintStyle,
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
        textBox(
          textController: textController,
          icon: icon,
          inputType: inputType,
          hint: hint,
          lines: lines,
          minLine: minLine,
          onTap: onTap,
          onChange: onChange,
          onSubmit: onSubmit,
          onTapOutside: onTapOutside,
          focusNode: focusNode,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          backColor: backColor,
          borderColor: borderColor,
          radiusSize: radiusSize,
          hintColor: hintColor,
          textStyle: textStyle,
          hintStyle: hintStyle,
          actions: actions,
        ),
      ],
    );
