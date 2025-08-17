import 'package:dompet_ku/controller/data/api/auth.dart';
import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/model/local/info_page.dart';
import 'package:dompet_ku/model/local/session.dart';
import 'package:dompet_ku/controller/service/blockchain.dart';
import 'package:dompet_ku/service/function/copy.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/service/function/log.dart';
import 'package:dompet_ku/service/router/navigator.dart';
import 'package:dompet_ku/service/router/screen.dart';
import 'package:dompet_ku/service/value/encrypt.dart';
import 'package:dompet_ku/service/value/number.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/assets/images.dart';
import 'package:dompet_ku/widget/load/modal.dart';
import 'package:dompet_ku/widget/message/dialogue_box.dart';
import 'package:dompet_ku/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hex/hex.dart';
import 'package:hugeicons/hugeicons.dart';

class CreateWalletPageController extends GetxController {
  final authApp = AuthAppController();
  final authData = AuthDataController();

  final encrypt = EncryptValue();
  final argument = Get.arguments;

  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();
  final txtFirstSeed = TextEditingController();
  final txtSecondSeed = TextEditingController();
  final txtThirdSeed = TextEditingController();

  var seedPhrase = ''.obs;
  var session = SessionModel().obs;

  var seedInput = <int>[].obs;
  var seedData = <int>[].obs;
  var seedSelected = <String>[].obs;

  var agreementChecked = false.obs;
  var counterValidation = 0.obs;

  var navIndex = 0.obs;
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
    try {
      normalScreenInterface(
        navBarColor: backColor_3,
        brightNessColor: Brightness.light,
      );

      loadData.value = true;
      seedPhrase.value = BlockchainUtils.createNewSeedPhrase();
      session.value.seedPhrase = seedPhrase.value;
      final ethPrivateKey =
          BlockchainUtils.generateEthPrivateKeyFromSeedPhrase(seedPhrase.value);

      if (ethPrivateKey != null) {
        final publicKey =
            BlockchainUtils.generateEthPublicKeyFromPrivateKey(ethPrivateKey);

        final walletAddress = BlockchainUtils.generateEthAddressFromPublicKey(
          publicKey ?? Uint8List(0),
        );

        session.value.eth?.privateKey = HEX.encode(ethPrivateKey.privateKey);
        session.value.eth?.publicKey = HEX.encode(publicKey?.toList() ?? []);
        session.value.eth?.walletAddress?.add(walletAddress?.hex ?? '');
      }

      loadData.value = false;
    } catch (e, trace) {
      printLog(e);
      printLog(trace);
    }
  }

  void actionMethod({
    required String mode,
    dynamic data,
  }) async {
    if (mode == 'copy-key') {
      await copyText(
        data: seedPhrase.value,
        message: 'Seed phrase copied!',
      );
    }

    if (mode == 'check-agreement') {
      agreementChecked.value = data;
    }

    if (mode == 'back-index') {
      navIndex.value -= 1;
    }

    if (mode == 'next-index') {
      navIndex.value += 1;
    }

    if (mode == 'add-seed' && seedSelected.length < 3) {
      seedSelected.add(data);
      loadData.value = true;
      loadData.value = false;
    }

    if (mode == 'reset-seed') {
      seedSelected.clear();
      loadData.value = true;
      loadData.value = false;
    }

    if (mode == 'submit' && navIndex.value == 0) {
      validatePassword();
    }

    if (mode == 'submit' && navIndex.value == 1) {
      validateSeedPhrase();
    }

    if (mode == 'submit' && navIndex.value == 2) {
      confirmSeedPhrase();
    }
  }

  void generateSeedIndex() {
    seedInput.value = generateRandomIntList(
      min: 0,
      max: 11,
      count: 3,
    );

    seedData.value = generateRandomIntList(
      min: 0,
      max: 11,
      count: 5,
      include: seedInput,
    );
  }

  void validatePassword() {
    if (txtPassword.text.isEmpty &&
        txtConfirmPassword.text.isEmpty &&
        !agreementChecked.value) {
      warningToast('Your password fields is empty\nPleas fill data fields');
    } else if (txtPassword.text.isEmpty) {
      warningToast('Your password field is Empty\nPleas fill data fields');
    } else if (txtConfirmPassword.text.isEmpty) {
      warningToast('Your password field is Empty\nPleas fill data fields');
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
        onAction: (index) {
          if (index == 0) {
            Navigate.back();
          }

          if (index == 1) {
            actionMethod(mode: 'next-index');
            Navigate.back();
          }
        },
      );
    }
  }

  void validateSeedPhrase() {
    dialogueBox(
      icon: HugeIcons.strokeRoundedInformationCircle,
      title: 'Are you sure?',
      description: 'Have you writed or remembered your seed phrase?',
      actions: ['no', 'yes'],
      isBottomSheet: true,
      onAction: (index) {
        if (index == 0) {
          Navigate.back();
        }

        if (index == 1) {
          actionMethod(mode: 'next-index');
          Navigate.back();
          generateSeedIndex();
        }
      },
    );
  }

  void confirmSeedPhrase() async {
    if (seedSelected.length < 3) {
      warningToast('You should select key word for confirmation!');
      return;
    }

    if (counterValidation.value >= 3) {
      dangerToast(
          'You have tried to validation 3 times!\nPlease try again from the start!');
      Navigate.back();

      return;
    }

    loadModal();

    final firstWord = seedPhrase.value.split(' ')[seedInput[0]];
    final secondWord = seedPhrase.value.split(' ')[seedInput[1]];
    final thirdWord = seedPhrase.value.split(' ')[seedInput[2]];

    final firstSelected = seedSelected[0];
    final secondSelected = seedSelected[1];
    final thirdSelected = seedSelected[2];

    if (firstWord != firstSelected ||
        secondWord != secondSelected ||
        thirdWord != thirdSelected) {
      dangerToast('Key word that you input is wrong!\nPlease, try again!');
      actionMethod(mode: 'reset-seed');

      counterValidation.value += 1;
      Navigate.back();
    } else {
      loadModal();

      final data = InfoPageModel(
        imageAsset: gifSuccess,
        title: 'Congratulations',
        description:
            "You've successfully protected your wallet. Remember to keep your seed phrase safe, it's your responsibility!\nDompet Ku cannot recover your wallet should you lose it.",
        buttonText: 'Done',
        route: Screen.MAIN_PAGE_ROUTE,
      );

      await createWallet();
      final argumen = {'data': data.toMap()};

      Get.offAllNamed(
        Screen.INFO_PAGE_ROUTE,
        arguments: argumen,
      );
    }
  }

  Future<void> createWallet() async {
    session.value.seedPhrase = encrypt.encryptData(seedPhrase.value);
    session.value.password = encrypt.encryptData(txtPassword.text);
    final ethPrivateKey =
        BlockchainUtils.generateEthPrivateKeyFromSeedPhrase(seedPhrase.value);

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
}
