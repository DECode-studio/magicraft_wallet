import 'dart:async';

import 'package:magicraft_wallet/controller/data/api/data.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/page/modal/network/main.dart';
import 'package:magicraft_wallet/service/function/copy.dart';
import 'package:magicraft_wallet/service/function/interface.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/service/router/screen.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/load/modal.dart';
import 'package:magicraft_wallet/widget/message/dialogue_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sidebarx/sidebarx.dart';

class MainPageController extends GetxController {
  final authApp = AuthAppController();
  final web3tData = Web3DataController();
  final argument = Get.arguments;

  final keyPage = GlobalKey<ScaffoldState>().obs;
  final drawerController =
      SidebarXController(selectedIndex: -1, extended: true);

  late StreamSubscription<LocalNetworkModel> networkStream;

  var network = LocalNetworkModel().obs;
  var navIndex = 0.obs;
  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    streamMethod(mode: 'stream');
  }

  @override
  void onClose() {
    super.onClose();
    streamMethod(mode: 'close');
  }

  void getData() async {
    normalScreenInterface(
      navBarColor: purple_1,
      brightNessColor: Brightness.light,
    );

    loadData.value = true;
    network.value = authApp.getCurrentNetwork();
    loadData.value = false;
  }

  void streamMethod({
    required String mode,
    dynamic data,
  }) {
    if (mode == 'stream') {
      networkStream = authApp.streamCurrentNetwork().listen((value) {
        if (network.value.chainId != value.chainId) {
          getData();
        }
      });
    }

    if (mode == 'close') {
      networkStream.cancel();
    }
  }

  void actionMethod({
    required String mode,
    dynamic data,
  }) async {
    if (mode == 'change-index') {
      navIndex.value = data;
    }

    if (mode == 'menu') {
      drawerController.selectIndex(-1);
      keyPage.value.currentState?.openDrawer();
    }

    if (mode == 'network') {
      networkModal();
    }

    if (mode == 'copy-address') {
      copyText(data: network.value.walletAddress ?? '');
    }

    if (mode == 'remove-wallet') {
      dialogueBox(
        icon: HugeIcons.strokeRoundedInformationCircle,
        title: 'Are you sure?',
        description: 'you can not recover your current wallet account.',
        actions: ['no', 'yes'],
        isBottomSheet: true,
        onAction: (index) async {
          if (index == 0) {
            Navigate.back();
          }

          if (index == 1) {
            loadModal();
            await authApp.clearSession();
            Get.offAllNamed(Screen.SPLASH_PAGE_ROUTE);
          }
        },
      );
    }
  }
}
