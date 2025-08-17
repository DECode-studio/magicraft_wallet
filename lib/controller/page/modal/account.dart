import 'dart:async';

import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/model/local/session.dart';
import 'package:dompet_ku/page/modal/network/main.dart';
import 'package:dompet_ku/page/modal/password/main.dart';
import 'package:dompet_ku/service/function/copy.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/service/value/encrypt.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountModalController extends GetxController {
  final authApp = AuthAppController();
  final encrypt = EncryptValue();
  late StreamSubscription<LocalNetworkModel> networkStream;

  var session = SessionModel().obs;
  var network = LocalNetworkModel().obs;

  final txtKey = TextEditingController();
  final txtEth = TextEditingController();

  var hideData = true.obs;
  var tabIndex = 0.obs;
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
    normalScreenInterface(
      navBarColor: purple_1,
      brightNessColor: Brightness.light,
    );
  }

  void getData() async {
    loadData.value = true;
    normalScreenInterface(
      navBarColor: backColor_3,
      brightNessColor: Brightness.light,
    );

    session.value = AuthAppController.getSession();
    network.value = authApp.getCurrentNetwork();

    txtKey.text = encrypt.decryptData(session.value.seedPhrase ?? '');
    txtEth.text = encrypt.decryptData(session.value.eth?.privateKey ?? '');

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
    if (mode == 'tab-index') {
      tabIndex.value = data;
    }

    if (mode == 'network') {
      networkModal();
    }

    if (mode == 'copy-address') {
      copyText(data: data);
    }

    if (mode == 'config-data') {
      final needVerification = data == false || hideData.value == true;

      if (needVerification) {
        final res = await passwordModal();
        if (!res) {
          dangerToast('Verification is rejected or canceled');
          return;
        }
      }

      hideData.value = data ?? !hideData.value;
    }
  }
}
