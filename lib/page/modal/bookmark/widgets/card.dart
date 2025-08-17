import 'package:dompet_ku/controller/page/modal/bookmark.dart';
import 'package:dompet_ku/model/api/response/bookmark.dart';
import 'package:dompet_ku/service/value/wallet.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/style/text.dart';
import 'package:flutter/material.dart';

Widget cardData(
  BookmarkModalController controller,
  AddressBookmarkModel data,
  Size size,
) =>
    InkWell(
      onTap: () => controller.actionMethod(
        mode: 'select',
        data: data,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.labelBookmark ?? '',
              style: bold_18_2,
            ),
            Text(
              shortenAddress(
                data.walletAddress ?? '',
                startChars: 10,
                endChars: 10,
              ),
              style: bold_15_5(color: thirdColor_1),
            ),
          ],
        ),
      ),
    );
