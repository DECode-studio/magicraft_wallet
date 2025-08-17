import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/model/api/main.dart';
import 'package:dompet_ku/model/api/request/network.dart';
import 'package:dompet_ku/model/api/response/network.dart';
import 'package:dompet_ku/model/api/response/provider.dart';
import 'package:dompet_ku/service/config/api.dart';
import 'package:dompet_ku/service/function/http_request.dart';
import 'package:dompet_ku/service/function/log.dart';

class NetworkDataController extends HttpRequest {
  Future<List<NetworkModel>> getListNeworks() async {
    var result = <NetworkModel>[];

    try {
      final session = AuthAppController.getSession();
      final req = GetNetworkRequest(
        walletAddress: session.eth?.walletAddress?[0] ?? '',
      );

      final url = Uri.parse('${Api.BASE_URL}${Api.NETWORKS_GET_URL}').replace(
        queryParameters: req.toMap(),
      );

      final res = await GET(url: url.toString());
      final data = ApiResponse<List<NetworkModel>>.fromJson(
        data: res.body,
        fromData: NetworkModel.fromListJson,
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

  Future<List<NetworkProviderModel>> getListProviders() async {
    var result = <NetworkProviderModel>[];

    try {
      final url = Uri.parse('${Api.BASE_URL}${Api.NETWORK_PROVIDER_GET_URL}');
      final res = await GET(url: url.toString());
      final data = ApiResponse<List<NetworkProviderModel>>.fromJson(
        data: res.body,
        fromData: NetworkProviderModel.fromListJson,
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

  Future<ApiResponse> addNetwork(
    AddNetworkRequest req,
  ) async {
    var result = ApiResponse();

    try {
      final url = '${Api.BASE_URL}${Api.NETWORK_ADD_URL}';
      final res = await POST(
        url: url.toString(),
        req: req.toJson(),
        isJson: true,
      );

      result = ApiResponse.fromJson(data: res.body);
      return result;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return result;
    }
  }
}
