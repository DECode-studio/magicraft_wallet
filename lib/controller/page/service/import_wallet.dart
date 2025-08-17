import 'dart:typed_data';

import 'package:magicraft_wallet/controller/data/api/auth.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/controller/service/blockchain.dart';
import 'package:magicraft_wallet/model/local/info_page.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/service/function/interface.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/service/router/screen.dart';
import 'package:magicraft_wallet/service/value/encrypt.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/assets/images.dart';
import 'package:magicraft_wallet/widget/load/modal.dart';
import 'package:magicraft_wallet/widget/message/dialogue_box.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';
import 'package:hugeicons/hugeicons.dart';

class ImportWalletPageController extends GetxController {
  final authApp = AuthAppController();
  final authData = AuthDataController();

  final encrypt = EncryptValue();
  final argument = Get.arguments;

  final txtKey = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();

  var session = SessionModel().obs;
  var hideData = false.obs;
  var agreementChecked = false.obs;

  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {
    super.onClose();
    fullScreenInterface();
  }

  void getData() async {
    normalScreenInterface(
      navBarColor: backColor_3,
      brightNessColor: Brightness.light,
    );

    loadData.value = true;
    loadData.value = false;
  }

  void actionMethod({
    required String mode,
    dynamic data,
  }) async {
    if (mode == 'config-data') {
      hideData.value = data ?? (!hideData.value);
    }

    if (mode == 'check-agreement') {
      agreementChecked.value = data;
    }
  }

  Future<void> createWallet() async {
    session.value.seedPhrase = encrypt.encryptData(txtKey.text);
    session.value.password = encrypt.encryptData(txtPassword.text);
    final ethPrivateKey =
        BlockchainUtils.generateEthPrivateKeyFromSeedPhrase(txtKey.text);

    if (ethPrivateKey != null) {
      final publicKey =
          BlockchainUtils.generateEthPublicKeyFromPrivateKey(ethPrivateKey);

      final walletAddress = BlockchainUtils.generateEthAddressFromPublicKey(
        publicKey ?? Uint8List(0),
      );

      final eth = WalletModel(
        privateKey: encrypt.encryptData(HEX.encode(ethPrivateKey.privateKey)),
        publicKey: encrypt.encryptData(HEX.encode(publicKey?.toList() ?? [])),
        walletAddress: [walletAddress?.hex ?? ''],
      );

      session.value.eth = eth;
    }

    await authApp.createSession(session.value.toJson());
    await authData.ethVerify();
  }

  void validate() {
    if (txtKey.text.isEmpty &&
        txtPassword.text.isEmpty &&
        txtConfirmPassword.text.isEmpty &&
        !agreementChecked.value) {
      warningToast(
          'All data field is still empty!\nPlease, fill all the fields!');
    } else if (txtKey.text.isEmpty) {
      warningToast(
          'Seed phrase field is still empty!\nPlease, fill all the fields!');
    } else if (txtPassword.text.isEmpty) {
      warningToast(
          'Password field is still empty!\nPlease, fill all the fields!');
    } else if (txtConfirmPassword.text.isEmpty) {
      warningToast(
          'Confirm password field is still empty!\nPlease, fill all the fields!');
    } else if (txtPassword.text != txtConfirmPassword.text) {
      warningToast('Password is not match!\nPlease, fill all the fields!');
    } else if (!agreementChecked.value) {
      warningToast('You should agree with our Terms and Condition to Continue');
    } else {
      dialogueBox(
        icon: HugeIcons.strokeRoundedInformationCircle,
        title: 'Are you sure?',
        description: 'Tha password that you input is ireversible.',
        actions: ['no', 'yes'],
        isBottomSheet: true,
        onAction: (index) async {
          if (index == 0) {
            Navigate.back();
          }

          if (index == 1) {
            loadModal();

            final data = InfoPageModel(
              imageAsset: gifSuccess,
              title: 'Congratulations',
              description:
                  "You've successfully protected your wallet. Remember to keep your seed phrase safe, it's your responsibility!\nMagicraft Wallet cannot recover your wallet should you lose it.",
              buttonText: 'Done',
              route: Screen.MAIN_PAGE_ROUTE,
            );

            final argumen = {'data': data.toMap()};
            await createWallet();

            Get.offAllNamed(
              Screen.INFO_PAGE_ROUTE,
              arguments: argumen,
            );
          }
        },
      );
    }
  }
}
