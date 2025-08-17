import 'dart:convert';

import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/service/function/http_request.dart';

class EthDataController extends HttpRequest {
  final authApp = AuthAppController();

  Future<bool> isContractAddress(
    String address,
  ) async {
    final network = authApp.getCurrentNetwork();

    final req = json.encode({
      'jsonrpc': '2.0',
      'id': 1,
      'method': 'eth_getCode',
      'params': [address, 'latest']
    });

    final res = await POST(
      url: network.detail?.publicRPC ?? '',
      req: req,
      isJson: true,
    );

    final result = json.decode(res.body);
    final code = result['result'].toString();

    return code != '0x';
  }
}
