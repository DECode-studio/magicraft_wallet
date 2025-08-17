import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/style/text_box.dart';

// ignore_for_file: must_be_immutable

class passwordField extends StatelessWidget {
  final TextEditingController textController;
  final IconData icon;
  final TextInputType inputType;
  final String hint;
  final Function()? onTap;
  final Function(String value)? onChange;
  final Function(String value)? onSubmit;
  final Color? backColor;
  final Color? borderColor;
  final Color? hintColor;
  final double? radiusSize;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  passwordField({
    required this.textController,
    required this.icon,
    required this.inputType,
    required this.hint,
    this.onTap,
    this.onChange,
    this.onSubmit,
    this.backColor,
    this.borderColor,
    this.hintColor,
    this.radiusSize,
    this.textStyle,
    this.hintStyle,
    super.key,
  });

  var passVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: customRoundedStyle(
          color: backColor ?? gray_3,
          size: radiusSize ?? 15,
        ),
        child: TextField(
          controller: textController,
          keyboardType: inputType,
          obscureText: passVisible.value,
          onChanged: onChange,
          onSubmitted: onSubmit,
          onTap: onTap,
          style: textStyle,
          decoration: passwordFieldStyle(
            hint,
            icon,
            passVisible.value,
            borderColor: borderColor,
            hintColor: hintColor,
            radiusSize: radiusSize,
            onTap: () {
              passVisible.value = !passVisible.value;
            },
          ),
        ),
      ),
    );
  }
}

Widget passwordFieldTitle({
  required TextEditingController textController,
  required IconData icon,
  required TextInputType inputType,
  required String hint,
  String? title,
  Function()? onTap,
  Function(String value)? onChange,
  Function(String value)? onSubmit,
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
          title ?? hint,
          style: titleStyle ?? bold_12_1,
        ),
        const SizedBox(
          height: 10,
        ),
        passwordField(
          textController: textController,
          icon: icon,
          inputType: inputType,
          hint: hint,
          onChange: onChange,
          onSubmit: onSubmit,
          onTap: onTap,
          backColor: backColor,
          borderColor: borderColor,
          radiusSize: radiusSize,
          hintColor: hintColor,
          textStyle: textStyle,
          hintStyle: hintStyle,
        )
      ],
    );
