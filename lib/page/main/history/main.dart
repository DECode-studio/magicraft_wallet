import 'package:magicraft_wallet/controller/page/main/history.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/screen.dart';

class HistoryFragment extends StatelessWidget {
  const HistoryFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetX<HistoryFragmentController>(
      init: HistoryFragmentController(),
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: transparent,
        body: screenPage(
          controller,
          size,
        ),
      ),
    );
  }
}
