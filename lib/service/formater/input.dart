import 'package:flutter/services.dart';

class PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numericValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    final formattedValue = '$numericValue%';
    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length - 1),
    );
  }
}
