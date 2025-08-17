import 'dart:async';

import 'package:dompet_ku/controller/data/api/data.dart';
import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/model/api/response/asset.dart';
import 'package:dompet_ku/model/local/session.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokenModalController extends GetxController {
  final authApp = AuthAppController();
  final web3tData = Web3DataController();

  late StreamSubscription<LocalNetworkModel> networkStream;
  final txtSearch = TextEditingController();

  var session = SessionModel().obs;
  var network = LocalNetworkModel().obs;
  var assets = AssetDetailModel().obs;

  var selectedToken = AssetModel().obs;
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
    assets.value = await web3tData.getListAssets();

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
    if (mode == 'search') {
      loadData.value = true;
      loadData.value = false;
    }

    if (mode == 'select') {
      Get.back(result: data);
    }
  }

  RxList<AssetModel> tokenList() {
    var listData = assets.value.listData ?? [];

    if (txtSearch.text.isNotEmpty) {
      listData = listData
          .where(
            (e) =>
                (e.tokenName ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.tokenName ?? '')
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
