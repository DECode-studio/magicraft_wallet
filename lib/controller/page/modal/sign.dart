import 'dart:async';

import 'package:magicraft_wallet/controller/data/api/data.dart';
import 'package:magicraft_wallet/controller/data/api/eth.dart';
import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/api/response/asset.dart';
import 'package:magicraft_wallet/model/api/response/network.dart';
import 'package:magicraft_wallet/model/local/ethereum.dart';
import 'package:magicraft_wallet/model/local/session.dart';
import 'package:magicraft_wallet/model/local/wallet_request.dart';
import 'package:magicraft_wallet/service/enum/wallet.dart';
import 'package:magicraft_wallet/service/function/interface.dart';
import 'package:magicraft_wallet/service/router/navigator.dart';
import 'package:magicraft_wallet/service/value/wallet.dart';
import 'package:magicraft_wallet/style/color.dart';
import 'package:magicraft_wallet/widget/load/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignModalController extends GetxController {
  final WalletRequestModel? request;
  SignModalController({this.request});

  final authApp = AuthAppController();
  final web3Data = Web3DataController();

  final ethData = EthDataController();
  late StreamSubscription<LocalNetworkModel> networkStream;

  var session = SessionModel().obs;
  var currentNetwork = LocalNetworkModel().obs;

  var token = AssetModel().obs;
  var network = LocalNetworkModel().obs;
  var listNetwork = <NetworkModel>[].obs;
  var assetDetail = AssetDetailModel().obs;

  var toAddress = ''.obs;
  var amount = 0.0.obs;
  var loadData = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    streamMethod(mode: 'stream');
  }

  @override
  void onReady() {
    super.onReady();
    normalScreenInterface(
      navBarColor: backColor_3,
      brightNessColor: Brightness.light,
    );
  }

  @override
  void onClose() {
    super.onClose();
    streamMethod(mode: 'close');
    normalScreenInterface(
      navBarColor: purple_1,
      brightNessColor: Brightness.light,
    );
  }

  void getData() async {
    loadData.value = true;

    session.value = AuthAppController.getSession();
    currentNetwork.value = authApp.getCurrentNetwork();
    listNetwork.value = await authApp.getListNetwork();

    if (request != null && request?.chainId != null) {
      final networks =
          listNetwork.where((e) => e.chainId == request?.chainId).toList();

      if (networks.isNotEmpty) {
        await authApp.createLocalNetwork(data: networks.first);
        network.value = authApp.getCurrentNetwork();
      }
    }

    if (request != null &&
        request?.type == WalletRequestType.SEND_TRANSACTION) {
      final nameSpace = network.value.chainId?.split(":").first;

      if (nameSpace == 'bip122') {}

      if (nameSpace == 'eip155') {
        await initSendETH();
      }

      if (nameSpace == 'solana') {}
    }

    network.value = authApp.getCurrentNetwork();
    loadData.value = false;
  }

  Future<void> initSendETH() async {
    final isErc20 = await ethData.isContractAddress(request?.address ?? '');

    if (isErc20) {
      final data = (request?.data ?? '').substring(8);
      token.value = await web3Data.getAsset(request?.address ?? '');

      if (token.value.tokenAddress == '' || token.value.tokenAddress == null) {
        loadModal();

        assetDetail.value = await web3Data.getListAssets();
        token.value = (assetDetail.value.listData ?? [])
            .firstWhere((e) => e.tokenAddress == request?.address);

        Navigate.back();
      }

      final addressHex = data.substring(0, 66);
      final address = '0x${addressHex.substring(26, 66)}';

      final valueHex = data.substring(66, 130);
      final value = BigInt.parse(valueHex, radix: 16);

      toAddress.value = address;
      amount.value = formatTokenAmount(value, token.value.tokenDecimals ?? 0);
    } else {
      final tx =
          EthSendTxRequest.fromMap((request?.params as List<dynamic>).first);

      token.value = await web3Data.getAsset(tx.contractAddress ?? '');
      toAddress.value = request?.address ?? '';
      amount.value = formatTokenAmount(
        tx.value ?? BigInt.parse('0'),
        token.value.tokenDecimals ?? 0,
      );
    }
  }

  void streamMethod({
    required String mode,
    dynamic data,
  }) {
    if (mode == 'stream') {
      networkStream = authApp.streamCurrentNetwork().listen((value) {
        if (network.value.chainId != value.chainId) {
          network.value = authApp.getCurrentNetwork();
          loadData.value = true;
          loadData.value = false;
        }
      });
    }

    if (mode == 'close') {
      networkStream.cancel();
    }
  }

  void confirm() {
    Get.back(result: true);
  }

  void reject() {
    Get.back(result: false);
  }
}
