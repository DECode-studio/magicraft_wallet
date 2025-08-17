import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';

Widget dropdown({
  required List data,
  required String initialData,
  required String hint,
  required IconData icon,
  required Function(dynamic) onChanged,
  Function(dynamic)? onActionClick,
  Widget? action,
  bool? underline,
  bool? readOnly,
  Color? backColor,
  Color? borderColor,
  Color? hintColor,
  double? radiusSize,
  TextStyle? titleStyle,
  TextStyle? textStyle,
  TextStyle? hintStyle,
}) =>
    Container(
      height: 50,
      padding: const EdgeInsets.only(right: 15),
      decoration: customRoundedStyle(
        color: backColor ?? gray_3,
        size: radiusSize ?? 15,
        isBorder: borderColor != null,
        borderColor: borderColor,
        borderSize: 1,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Icon(
                icon,
                color: hintColor ?? gray_1,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  hint,
                  style: hintColor != null
                      ? normal_15_5(color: hintColor)
                      : normal_15_3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: data
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: hintColor ?? gray_1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: textStyle ?? normal_15_1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      initialData == item
                          ? Container()
                          : onActionClick != null
                              ? GestureDetector(
                                  onTap: () => onActionClick(item),
                                  child: action ?? Container(),
                                )
                              : Container(),
                    ],
                  ),
                ),
              )
              .toList(),
          value: initialData == '' ? null : initialData,
          onChanged: onChanged,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: backColor ?? white,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
        ),
      ),
    );

Widget titleDropdown({
  required List data,
  required String initialData,
  required String hint,
  required IconData icon,
  required Function(dynamic) onChanged,
  Function(dynamic)? onActionClick,
  Widget? action,
  bool? underline,
  bool? readOnly,
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
          hint,
          style: titleStyle ?? bold_12_1,
        ),
        const SizedBox(
          height: 10,
        ),
        dropdown(
          data: data,
          initialData: initialData,
          hint: hint,
          icon: icon,
          onChanged: onChanged,
          underline: underline,
          readOnly: readOnly,
          backColor: backColor,
          borderColor: borderColor,
          hintColor: hintColor,
          radiusSize: radiusSize,
          textStyle: textStyle,
          hintStyle: hintStyle,
        ),
      ],
    );
