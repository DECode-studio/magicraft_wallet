import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:magicraft_wallet/style/box.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/text_field/text_field.dart';

Widget searchDropdown({
  required TextEditingController textController,
  required List data,
  required String initialData,
  required String hint,
  required IconData icon,
  required Function(dynamic) onChanged,
  bool? underline,
  bool? readOnly,
  Color? backColor,
  Color? borderColor,
  Color? hintColor,
  double? radiusSize,
  TextStyle? textStyle,
  TextStyle? hintStyle,
}) =>
    Container(
      padding: const EdgeInsets.only(right: 15),
      decoration: customRoundedStyle(
        color: backColor ?? gray_3,
        size: radiusSize ?? 15,
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
                width: 4,
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
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: textStyle ?? normal_15_1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          value: initialData == '' ? null : initialData,
          onChanged: onChanged,
          dropdownSearchData: DropdownSearchData(
            searchController: textController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: textBox(
              textController: textController,
              icon: icon,
              inputType: TextInputType.text,
              hint: hint,
              readOnly: readOnly,
              backColor: backColor,
              borderColor: borderColor,
              hintColor: hintColor,
              radiusSize: radiusSize,
              textStyle: textStyle,
              hintStyle: hintStyle,
            ),
            searchMatchFn: (item, searchValue) => item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase()),
          ),
          onMenuStateChange: readOnly == true
              ? null
              : (isOpen) {
                  if (!isOpen) {
                    textController.clear();
                  }
                },
        ),
      ),
    );

Widget titleSearchDropdown({
  required TextEditingController textController,
  required List data,
  required String initialData,
  required String hint,
  required IconData icon,
  required Function(dynamic) onChanged,
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
        searchDropdown(
          textController: textController,
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
