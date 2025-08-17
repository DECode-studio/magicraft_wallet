import 'package:flutter/material.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:dompet_ku/widget/assets/images.dart';

Widget emptyData() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(gifEmpty),
        Text(
          'Data is still Empty',
          style: bold_18_4,
        ),
      ],
    );

Widget notFoundData() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(gifEmpty),
        Text(
          'Data is Not Found',
          style: bold_18_4,
        ),
      ],
    );
