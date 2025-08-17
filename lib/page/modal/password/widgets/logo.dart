import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/assets/images.dart';
import 'package:flutter/material.dart';

Widget logoApp() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          appIcon,
          height: 100,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Dompet Ku',
          style: normal_25_5(
            color: thirdColor_1,
          ),
        ),
        Text(
          'most secure and reliable\nweb3 wallet',
          style: normal_15_2,
          textAlign: TextAlign.center,
        ),
      ],
    );
