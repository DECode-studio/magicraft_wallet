import 'package:magicraft_wallet/model/local/info_page.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPageController extends GetxController {
  final argument = Get.arguments;

  late IconData? icon;
  late String? imageAsset;
  late String? title;
  late String? description;
  late String? buttonText;
  late String? route;

  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    loadData.value = true;

    final page = InfoPageModel.fromMap(argument['data']);
    icon = page.icon;
    imageAsset = page.imageAsset;
    title = page.title;
    description = page.description;
    buttonText = page.buttonText;
    route = page.route;

    loadData.value = false;
  }

  void actionClick() {
    if (route == null) {
      Navigate.back();
    } else {
      Get.offAllNamed(route ?? "");
    }
  }
}
