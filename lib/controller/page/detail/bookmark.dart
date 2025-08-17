import 'package:magicraft_wallet/controller/data/api/bookmark.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/api/response/bookmark.dart';
import 'package:magicraft_wallet/page/modal/bookmark/main.dart';
import 'package:magicraft_wallet/page/modal/password/main.dart';
import 'package:magicraft_wallet/service/function/interface.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/load/modal.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkPageController extends GetxController {
  final authApp = AuthAppController();
  final bookmarkData = BookmarkDataController();
  final argument = Get.arguments;

  final txtSearch = TextEditingController();

  var listBookmark = <AddressBookmarkModel>[].obs;
  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    normalScreenInterface(
      navBarColor: backColor_3,
      brightNessColor: Brightness.light,
    );

    if (authApp.isJwtExpired()) {
      final result = await passwordModal();

      if (!result) {
        dangerToast('You should confirm password to continue@');
        Navigate.back();
        return;
      }
    }

    loadData.value = true;
    listBookmark.value = await bookmarkData.getAddressBookmark();
    loadData.value = false;
  }

  void actionMethod({
    required String mode,
    dynamic data,
  }) async {
    if (mode == 'add') {
      await bookmarkModal(argument: {
        'type': 'add-address',
      });
      getData();
    }

    if (mode == 'delete') {
      loadModal();
      await bookmarkData.deleteAddressBookmark(data);
      Navigate.back();

      loadData.value = true;
      loadData.value = false;
    }
  }

  RxList<AddressBookmarkModel> bookmarkList() {
    var listData = listBookmark;

    if (txtSearch.text.isNotEmpty) {
      listData = listData
          .where(
            (e) =>
                (e.labelBookmark ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.labelBookmark ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()) ||
                (e.walletAddress ?? '').toLowerCase() ==
                    txtSearch.text.toLowerCase() ||
                (e.walletAddress ?? '')
                    .toLowerCase()
                    .contains(txtSearch.text.toLowerCase()),
          )
          .toList()
          .obs;
    }

    return listData;
  }
}
