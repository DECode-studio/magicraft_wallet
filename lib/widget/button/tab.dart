import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:flutter/material.dart';

Widget tabBar({
  required int initIndex,
  required List data,
  required Function(int index) onTap,
  bool shadow = true,
  bool isBorder = false,
  EdgeInsetsGeometry? margin,
  Color? selectedColor,
  Color? selectedTextColor,
  Color? unSelectedColor,
  Color? unSelectedTextColor,
  Color? borderColor,
  double? borderRadius,
}) =>
    Container(
      margin:
          margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: shadow
          ? customRoundedShadowStyle(
              color: unSelectedColor ?? white,
              size: borderRadius,
              isBorder: isBorder,
              borderColor: borderColor ?? mainColor_1,
            )
          : customRoundedStyle(
              color: unSelectedColor ?? gray_3,
              size: borderRadius,
              isBorder: isBorder,
              borderColor: borderColor ?? mainColor_1,
            ),
      child: Row(
        children: List.generate(
          data.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: initIndex == index
                    ? shadow
                        ? customRoundedShadowStyle(
                            color: selectedColor ?? mainColor_1,
                            size: borderRadius,
                          )
                        : customRoundedStyle(
                            color: selectedColor ?? mainColor_1,
                            size: borderRadius,
                          )
                    : null,
                child: Text(
                  data[index],
                  style: initIndex == index
                      ? bold_15_5(color: selectedTextColor ?? white)
                      : normal_15_5(color: unSelectedTextColor ?? mainColor_1),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
