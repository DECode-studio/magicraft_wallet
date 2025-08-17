import 'package:magicraft_wallet/controller/data/api/bookmark.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/api/request/bookmark.dart';
import 'package:magicraft_wallet/model/api/response/bookmark.dart';
import 'package:magicraft_wallet/page/modal/password/main.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/widget/load/modal.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkModalController extends GetxController {
  final authApp = AuthAppController();
  final bookmarkData = BookmarkDataController();
  final argument = Get.arguments;

  final txtSearch = TextEditingController();
  final txtNameSpace = TextEditingController();
  final txtLabel = TextEditingController();
  final txtWallet = TextEditingController();
  final txtUrl = TextEditingController();

  var listBookmark = <AddressBookmarkModel>[].obs;
  var listNamespace = ['Bitcoin', 'Ethereum', 'Solana'];

  var type = ''.obs;
  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    if (authApp.isJwtExpired()) {
      final result = await passwordModal();

      if (!result) {
        dangerToast('You should confirm password to continue@');
        Navigate.back();
        return;
      }
    }

    loadData.value = true;
    if (argument != null && argument['type'] != null) {
      type.value = argument['type'];
    }

    if (type.value == 'select') {
      listBookmark.value = await bookmarkData.getAddressBookmark();
    }

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
      Navigate.back();
      Get.back(result: data);
    }

    if (mode == 'set-chain') {
      txtNameSpace.text = data;
      loadData.value = true;
      loadData.value = false;
    }
  }

  void valudate() {
    if (type.value == 'add-url') {
      pushUrlData();
    }

    if (type.value == 'add-address') {
      pushAddressData();
    }
  }

  void pushUrlData() async {
    if (txtLabel.text.isEmpty && txtUrl.text.isEmpty) {
      warningToast('All bookmark fields is empty!\nPlease, fill all data!');
      return;
    }

    if (txtLabel.text.isEmpty) {
      warningToast('Label field is empty!\nPlease, fill all data!');
      return;
    }

    if (txtUrl.text.isEmpty) {
      warningToast('Url field is empty!\nPlease, fill all data!');
      return;
    }

    final domainPattern = RegExp(
      r'^(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
    );

    var isUrl = false;

    if (txtUrl.text.startsWith(RegExp(r'https?://'))) {
      isUrl = Uri.tryParse(txtUrl.text)?.host.isNotEmpty ?? false;
    } else if (domainPattern.hasMatch(txtUrl.text)) {
      isUrl = true;
      txtUrl.text = 'https://${txtUrl.text}';
    }

    if (!isUrl) {
      txtUrl.text =
          'https://www.google.com/search?q=${Uri.encodeComponent(txtUrl.text)}';
    }

    loadModal();
    final req = UrlBookmarkRequest(
      labelBookmark: txtLabel.text,
      urlBookmark: txtUrl.text,
    );

    await bookmarkData.addUrlBookmark(req);
    Navigate.back();
    Navigate.back();
  }

  void pushAddressData() async {
    if (txtNameSpace.text.isEmpty &&
        txtLabel.text.isEmpty &&
        txtWallet.text.isEmpty) {
      warningToast('All bookmark fields is empty!\nPlease, fill all data!');
      return;
    }

    if (txtNameSpace.text.isEmpty) {
      warningToast('Name space still not selected!\nPlease, fill all data!');
      return;
    }

    if (txtLabel.text.isEmpty) {
      warningToast('Label field is empty!\nPlease, fill all data!');
      return;
    }

    if (txtWallet.text.isEmpty) {
      warningToast('Wallet address field is empty!\nPlease, fill all data!');
      return;
    }

    loadModal();
    final req = AddressBookmarkRequest(
      nameSpace: checkNameSpace(),
      labelBookmark: txtLabel.text,
      walletAddress: txtWallet.text,
    );

    await bookmarkData.addAddressBookmark(req);
    Navigate.back();
    Navigate.back();
  }

  String checkNameSpace() {
    if (txtNameSpace.text.toLowerCase() == 'bitcoin') {
      return 'bip122';
    }

    if (txtNameSpace.text.toLowerCase() == 'ethereum') {
      return 'eip155';
    }

    if (txtNameSpace.text.toLowerCase() == 'solana') {
      return 'solana';
    }

    return '';
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
