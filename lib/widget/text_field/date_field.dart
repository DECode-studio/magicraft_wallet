import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dompet_ku/style/box.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/style/text_box.dart';

Widget datePicker({
  required String hint,
  required IconData icon,
  required Function(DateTime?)? onChange,
  DateTime? initData,
  bool dateOnly = true,
  bool timeOnly = false,
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
      decoration: customRoundedStyle(
        color: backColor ?? gray_3,
        size: radiusSize ?? 15,
        // borderColor: borderColor,
        // borderSize: 0.1,
      ),
      child: DateTimeField(
        initialValue: initData,
        format: DateFormat(timeOnly
            ? 'HH:mm'
            : dateOnly
                ? 'dd MMMM yyyy'
                : 'dd/MM/yyyy HH:mm'),
        readOnly: readOnly ?? false,
        decoration: textFieldStyle(
          hint: hint,
          icon: icon,
          borderColor: borderColor,
          hintColor: hintColor,
          radiusSize: radiusSize,
        ),
        onChanged: onChange,
        style: textStyle,
        onShowPicker: (context, currentValue) async {
          DateTime? time;

          if (timeOnly) {
            final data = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );

            time = DateTimeField.convert(data);
          } else {
            time = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
            ).then((DateTime? date) async {
              if (dateOnly) {
                return date;
              } else {
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              }
            });
          }

          return time;
        },
      ),
    );

Widget dateTitlePicker({
  required String hint,
  required IconData icon,
  required Function(DateTime?)? onChange,
  DateTime? initData,
  bool dateOnly = true,
  bool timeOnly = false,
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
        datePicker(
          hint: hint,
          icon: icon,
          onChange: onChange,
          initData: initData,
          dateOnly: dateOnly,
          timeOnly: timeOnly,
          readOnly: readOnly,
          backColor: backColor,
          hintColor: hintColor,
          radiusSize: radiusSize,
          borderColor: borderColor,
          titleStyle: titleStyle,
          textStyle: textStyle,
          hintStyle: hintStyle,
        ),
      ],
    );
