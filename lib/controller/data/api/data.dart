import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/model/api/main.dart';
import 'package:magicraft_wallet/model/api/request/web3.dart';
import 'package:magicraft_wallet/model/api/response/asset.dart';
import 'package:magicraft_wallet/model/api/response/history.dart';
import 'package:magicraft_wallet/service/config/api.dart';
import 'package:magicraft_wallet/service/function/http_request.dart';
import 'package:magicraft_wallet/service/function/log.dart';

class Web3DataController extends HttpRequest {
  final authApp = AuthAppController();

  Future<AssetModel> getAsset(
    String contractAddress,
  ) async {
    var result = AssetModel();

    try {
      final network = authApp.getCurrentNetwork();
      final req = Web3Request(
        chainId: network.chainId,
        walletAddress: network.walletAddress?.toLowerCase(),
        contractAddress: contractAddress.toLowerCase(),
      );

      final url = Uri.parse('${Api.BASE_URL}${Api.ASSET_DETAIL_GET_URL}').replace(
        queryParameters: req.toMap(),
      );

      final res = await GET(url: url.toString());
      final data = ApiResponse<AssetModel>.fromJson(
        data: res.body,
        fromData: AssetModel.fromJson,
      );

      result = data.data ?? AssetModel();
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<AssetDetailModel> getListAssets() async {
    var result = AssetDetailModel();

    try {
      final network = authApp.getCurrentNetwork();
      final req = Web3Request(
        chainId: network.chainId,
        walletAddress: network.walletAddress,
      );

      final url = Uri.parse('${Api.BASE_URL}${Api.ASSETS_GET_URL}');

      final res = await POST(
        url: url.toString(),
        isJson: true,
        req: req.toJson(),
      );

      final data = ApiResponse<AssetDetailModel>.fromJson(
        data: res.body,
        fromData: AssetDetailModel.fromJson,
      );

      result = data.data ?? AssetDetailModel();
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }

  Future<List<TransactionHistoryModel>> getListHistory() async {
    var result = <TransactionHistoryModel>[];

    try {
      final network = authApp.getCurrentNetwork();
      final req = Web3Request(
        chainId: network.chainId,
        walletAddress: network.walletAddress,
      );

      final url = Uri.parse('${Api.BASE_URL}${Api.HISTORY_GET_URL}');

      final res = await POST(
        url: url.toString(),
        isJson: true,
        req: req.toJson(),
      );

      final data = ApiResponse<List<TransactionHistoryModel>>.fromJson(
        data: res.body,
        fromData: TransactionHistoryModel.fromListJson,
      );

      result = data.data ?? [];
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }
}
