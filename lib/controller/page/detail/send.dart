import 'dart:async';

import 'package:dompet_ku/controller/data/api/data.dart';
import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/controller/service/ethereum.dart';
import 'package:dompet_ku/controller/service/wallet.dart';
import 'package:dompet_ku/model/api/response/asset.dart';
import 'package:dompet_ku/model/local/ethereum.dart';
import 'package:dompet_ku/model/local/session.dart';
import 'package:dompet_ku/page/modal/bookmark/main.dart';
import 'package:dompet_ku/page/modal/network/main.dart';
import 'package:dompet_ku/page/modal/password/main.dart';
import 'package:dompet_ku/page/modal/token/main.dart';
import 'package:dompet_ku/service/function/interface.dart';
import 'package:dompet_ku/service/router/navigator.dart';
import 'package:dompet_ku/service/value/wallet.dart';
import 'package:dompet_ku/style/color.dart';
import 'package:dompet_ku/widget/load/modal.dart';
import 'package:dompet_ku/widget/message/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendPageController extends GetxController {
  final authApp = AuthAppController();
  final web3Data = Web3DataController();

  late StreamSubscription<LocalNetworkModel> networkStream;

  final txtFrom = TextEditingController();
  final txtTo = TextEditingController();
  final txtAmount = TextEditingController(text: '0');
  final txtHex = TextEditingController();

  var session = SessionModel().obs;
  var network = LocalNetworkModel().obs;

  var asset = AssetModel().obs;
  var assetDetail = AssetDetailModel().obs;

  var dataHexStatus = false.obs;
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
    normalScreenInterface(
      navBarColor: purple_1,
      brightNessColor: Brightness.light,
    );
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
    session.value = AuthAppController.getSession();
    network.value = authApp.getCurrentNetwork();

    txtFrom.text = network.value.walletAddress ?? '';
    assetDetail.value = await web3Data.getListAssets();

    if ((network.value.chainId ?? '').split(':').first != 'eip155') {
      dataHexStatus.value = false;
    }

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
    if (mode == 'network') {
      networkModal();
    }

    if (mode == 'search-asset') {
      final result = await tokenModal();
      asset.value = result ?? AssetModel();
    }

    if (mode == 'max-amount') {
      txtAmount.text = (asset.value.tokenBalance ?? 0).toString();
    }

    if (mode == 'bookmark') {
      final result = await bookmarkModal(
        argument: {'type': 'select'},
      );

      txtTo.text = result?.walletAddress ?? '';
    }

    if (mode == 'data-hex-status') {
      dataHexStatus.value = data;
      txtAmount.text = '0';

      if (dataHexStatus.value) {
        if ((assetDetail.value.listData ?? []).isNotEmpty) {
          asset.value = (assetDetail.value.listData ?? []).first;
        }
      } else {
        asset.value = AssetModel();
      }

      loadData.value = true;
      loadData.value = false;
    }
  }

  void validate() async {
    if (txtFrom.text.isEmpty) {
      warningToast('From address is still empty!');
    } else if (txtTo.text.isEmpty) {
      warningToast('Destination address is still empty!');
    } else if (!dataHexStatus.value && asset.value.tokenSymbol == null) {
      warningToast('Token not selected yet!');
    } else if (!dataHexStatus.value && txtAmount.text.isEmpty) {
      warningToast('Amount value is still empty!');
    } else if (txtAmount.text.isNotEmpty &&
        double.parse(txtAmount.text) > (asset.value.tokenBalance ?? 0)) {
      warningToast(
          'Amount value exceed maximum balance\n${asset.value.tokenBalance} ${asset.value.tokenSymbol}');
    } else if (dataHexStatus.value && txtHex.text.isEmpty) {
      warningToast('HEX data field is still empty!');
    } else {
      loadModal();
      await sendTx();
      getData();
    }
  }

  Future<void> sendTx() async {
    final nameSpace = network.value.chainId?.split(":").first;

    if (nameSpace == 'bip122') {}

    if (nameSpace == 'eip155') {
      await sendEth();
    }

    if (nameSpace == 'solana') {}
  }

  Future<void> sendEth() async {
    final chainId = int.parse(network.value.chainId!.split(":").last);

    if (asset.value.tokenType?.toLowerCase() == 'native') {
      final amount = parseTokenAmount(
        txtAmount.text,
        asset.value.tokenDecimals ?? 0,
      );

      try {
        await WalletAppController.ethSendTransaction(
          '',
          [
            EthSendTxRequest(
              chainId: chainId,
              contractAddress: asset.value.tokenAddress,
              to: txtTo.text,
              value: amount,
              data: txtHex.text,
            ).toMap()
          ],
        );
      } catch (e) {
        warningToast(e.toString());
        Navigate.back();
        return;
      }
    }

    if (asset.value.tokenType?.toLowerCase() == 'erc20') {
      final amount = parseTokenAmount(
        txtAmount.text,
        asset.value.tokenDecimals ?? 0,
      );

      final data = encodeErc20Transfer(
        toAddress: txtTo.text,
        amount: amount,
      );
      try {
        await WalletAppController.ethSendTransaction(
          '',
          [
            EthSendTxRequest(
              chainId: chainId,
              contractAddress: asset.value.tokenAddress,
              to: asset.value.tokenAddress,
              data: data,
            ).toMap()
          ],
        );
      } catch (e) {
        warningToast(e.toString());
        Navigate.back();
        return;
      }
    }

    successToast('Success!');
    Navigate.back();
  }
}
