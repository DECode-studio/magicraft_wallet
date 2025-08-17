import 'dart:async';

import 'package:magicraft_wallet/controller/data/api/data.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/api/response/history.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/page/modal/network/main.dart';
import 'package:magicraft_wallet/service/function/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryFragmentController extends GetxController {
  final authApp = AuthAppController();
  final web3tData = Web3DataController();

  late StreamSubscription<LocalNetworkModel> networkStream;
  final txtSearch = TextEditingController();

  var session = SessionModel().obs;
  var network = LocalNetworkModel().obs;
  var listHistory = <TransactionHistoryModel>[].obs;

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
    listHistory.value = await web3tData.getListHistory();

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
  }) {
    if (mode == 'search') {
      loadData.value = true;
      loadData.value = false;
    }

    if (mode == 'network') {
      networkModal();
    }

    if (mode == 'detail') {
      final tx = data as TransactionHistoryModel;
      final url = '${network.value.detail?.networkScan}/tx/${tx.hash}';

      launchUri(url);
    }
  }

  RxList<TransactionHistoryModel> historyList() {
    var listData = listHistory;

    if (txtSearch.text.isNotEmpty) {
      listData = listData
          .where(
            (e) =>
                (e.from ?? '').toLowerCase() == txtSearch.text.toLowerCase() ||
                (e.from ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.to ?? '').toLowerCase() == txtSearch.text.toLowerCase() ||
                (e.to ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.hash ?? '').toLowerCase() == txtSearch.text.toLowerCase() ||
                (e.hash ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.block ?? 0).toString() == txtSearch.text ||
                (e.timestamp ?? 0).toString() == txtSearch.text,
          )
          .toList()
          .obs;
    }

    return listData;
  }
}
