import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicraft_wallet/style/color.dart';

const titleToast = 'Dompet Ku Message';

void successToast(
  String text,
) =>
    Get.snackbar(
      titleToast,
      text,
      colorText: white,
      // backgroundColor: backColor_3,
      icon: Icon(
        Icons.check_circle_rounded,
        color: green,
      ),
    );

void warningToast(
  String text,
) =>
    Get.snackbar(
      titleToast,
      text,
      colorText: white,
      // backgroundColor: backColor_3,
      icon: Icon(
        Icons.warning,
        color: yellow,
      ),
    );

void dangerToast(
  String text,
) =>
    Get.snackbar(
      titleToast,
      text,
      colorText: white,
      // backgroundColor: backColor_3,
      icon: Icon(
        Icons.dangerous,
        color: red,
      ),
    );

void bottomToast(
  String text,
) =>
    Get.snackbar(
      titleToast,
      text,
      colorText: white,
      // backgroundColor: backColor_3,
      snackPosition: SnackPosition.BOTTOM,
    );
