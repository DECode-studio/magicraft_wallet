import 'package:dompet_ku/controller/data/api/network.dart';
import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/model/api/response/network.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/service/router/navigator.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/load/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkModalController extends GetxController {
  final authApp = AuthAppController();
  final netwokrData = NetworkDataController();

  final txtSearch = TextEditingController();

  var listNetwork = <NetworkModel>[].obs;
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
    loadData.value = true;
    normalScreenInterface(
      navBarColor: backColor_3,
      brightNessColor: Brightness.light,
    );

    listNetwork.value = await netwokrData.getListNeworks();
    listNetwork.sort((a, b) => (a.chainId ?? '').compareTo(b.chainId ?? ''));

    loadData.value = false;
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
      loadModal();
      await authApp.createLocalNetwork(data: data);

      Navigate.back();
      Navigate.back();
    }
  }

  RxList<NetworkModel> networkList() {
    var listData = listNetwork;

    if (txtSearch.text.isNotEmpty) {
      listData = listData
          .where(
            (e) =>
                (e.nameNetwork ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.nameNetwork ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.chainId ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.chainId ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()),
          )
          .toList()
          .obs;
    }

    return listData;
  }
}
