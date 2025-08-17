import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/service/router/navigator.dart';
import 'package:dompet_ku/service/router/screen.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/message/dialogue_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class OtherPageController extends GetxController {
  final authApp = AuthAppController();
  final argument = Get.arguments;

  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {
    super.onClose();
    normalScreenInterface(
      navBarColor: purple_1,
      brightNessColor: Brightness.light,
    );
  }

  void getData() async {
    normalScreenInterface(
      navBarColor: backColor_3,
      brightNessColor: Brightness.light,
    );

    loadData.value = true;
    loadData.value = false;
  }

  void maintenance() {
    dialogueBox(
      icon: HugeIcons.strokeRoundedTools,
      title: 'Coming Soon',
      description:
          'this feature menu is still under maintenance.\nPlease, wait untill published',
      actions: ['ok'],
      isBottomSheet: true,
      onAction: (index) async {
        if (index == 0) {
          Navigate.back();
        }
      },
    );
  }

  void actionMethod({
    required String mode,
    dynamic data,
  }) async {
    if (mode == 'address-bookmark') {
      Get.toNamed(Screen.BOOKMARK_PAGE_ROUTE);
    }

    if (mode == 'mint-nft') {
      maintenance();
    }

    if (mode == 'mint-token') {
      maintenance();
    }

    if (mode == 'swap-token') {
      maintenance();
    }

    if (mode == 'recomendation') {
      maintenance();
    }
  }
}
