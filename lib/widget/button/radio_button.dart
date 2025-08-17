import 'package:flutter/material.dart';
import 'package:dompet_ku/model/local/radio_option.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';

Widget radioButton({
  required List<RadioOption> options,
  String? defaultValue,
  ValueChanged<String>? onChanged,
}) =>
    StatefulBuilder(
      builder: (context, setState) {
        String? selectedValue = defaultValue;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: options.map((option) {
            final isSelected = selectedValue == option.value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = option.value;
                });

                if (onChanged != null) {
                  onChanged(option.value);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected ? mainColor_1 : black_1.withAlpha(100),
                      size: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.label,
                            style: isSelected ? bold_15_4 : normal_15_1,
                          ),
                          if (option.subLabel != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                option.subLabel ?? '',
                                style: isSelected ? bold_12_4 : normal_12_1,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
