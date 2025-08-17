import 'package:magicraft_wallet/controller/page/main/history.dart';
import 'package:magicraft_wallet/model/api/response/history.dart';
import 'package:magicraft_wallet/service/formater/date.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/style/text.dart';
import 'package:magicraft_wallet/widget/data/text_data.dart';
import 'package:flutter/material.dart';

Widget cardData(
  HistoryFragmentController controller,
  TransactionHistoryModel data,
  Size size,
) =>
    InkWell(
      onTap: () => controller.actionMethod(
        mode: 'detail',
        data: data,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              dateFormater(
                  DateTime.fromMillisecondsSinceEpoch(data.timestamp ?? 0)),
              style: bold_15_5(color: thirdColor_1),
            ),
            textData(
                title: 'From',
                data: data.from,
                titleStyle: bold_15_2,
                textStyle: normal_15_5(color: purple_3)),
            textData(
                title: 'To',
                data: data.to,
                titleStyle: bold_15_2,
                textStyle: normal_15_5(color: purple_3)),
            textData(
                title: 'Tx Hash',
                data: data.hash,
                titleStyle: bold_15_2,
                textStyle: normal_15_5(color: purple_3)),
            Divider(
              color: purple_3,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
