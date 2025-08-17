import 'dart:async';

import 'package:magicraft_wallet/controller/data/api/data.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/api/response/asset.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/page/modal/account/main.dart';
import 'package:magicraft_wallet/page/modal/network/main.dart';
import 'package:magicraft_wallet/service/router/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletFragmentController extends GetxController {
  final authApp = AuthAppController();
  final web3tData = Web3DataController();

  late StreamSubscription<LocalNetworkModel> networkStream;
  final txtSearch = TextEditingController();

  var session = SessionModel().obs;
  var network = LocalNetworkModel().obs;
  var asset = AssetDetailModel().obs;

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
    streamMethod(mode: 'close');
  }

  void getData() async {
    loadData.value = true;

    session.value = AuthAppController.getSession();
    network.value = authApp.getCurrentNetwork();
    asset.value = await web3tData.getListAssets();

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

    if (mode == 'search') {
      loadData.value = true;
      loadData.value = false;
    }

    if (mode == 'network') {
      networkModal();
    }

    if (mode == 'send') {
      Get.toNamed(Screen.SEND_PAGE_ROUTE);
    }

    if (mode == 'account') {
      accountModal();
    }

    if (mode == 'bookmark') {
      Get.toNamed(Screen.BOOKMARK_PAGE_ROUTE);
    }

    if (mode == 'other') {
      Get.toNamed(Screen.OTHER_PAGE_ROUTE);
    }
  }

  RxList<AssetModel> listAsset() {
    var listData = asset.value.listData ?? [];

    if (txtSearch.text.isNotEmpty) {
      listData = listData
          .where(
            (e) =>
                (e.tokenName ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.tokenName ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.tokenSymbol ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.tokenSymbol ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.tokenAddress ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.tokenAddress ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()),
          )
          .toList();
    }

    return listData.obs;
  }
}
