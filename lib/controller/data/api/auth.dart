import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/controller/service/ethereum.dart';
import 'package:magicraft_wallet/model/api/main.dart';
import 'package:magicraft_wallet/model/api/request/verivy.dart';
import 'package:magicraft_wallet/model/api/response/verivy.dart';
import 'package:magicraft_wallet/service/config/api.dart';
import 'package:magicraft_wallet/service/formater/date.dart';
import 'package:magicraft_wallet/service/function/http_request.dart';
import 'package:magicraft_wallet/service/function/log.dart';
import 'package:magicraft_wallet/service/value/encrypt.dart';

class AuthDataController extends HttpRequest {
  final authApp = AuthAppController();
  final encrypt = EncryptValue();

  Future<VerifyModel> ethVerify() async {
    try {
      final session = AuthAppController.getSession();
      final message =
          'I sign this transaction on ${dateDayTimeFormater(DateTime.now())}';
      final hexSignature = signMessageETH(
        mode: 'eth',
        message: message,
      );

      final req = VerifyRequest(
        chain: 'eth',
        message: message,
        signature: hexSignature,
        walletAddress: session.eth?.walletAddress?.first,
      );

      final url = Uri.parse('${Api.BASE_URL}${Api.VERIVY_AUTH_URL}');
      final res = await POST(
        url: url.toString(),
        req: req.toJson(),
        isJson: true,
      );

      final data = ApiResponse<VerifyModel>.fromJson(
        data: res.body,
        fromData: VerifyModel.fromJson,
      );

      final auth = data.data ?? VerifyModel();
      session.token = encrypt.encryptData(auth.token ?? '');
      authApp.createSession(session.toJson());

      return auth;
    } catch (e, trace) {
      printLog(
          'error ${StackTrace.current.toString().split("\n")[0].split(" ")[1]} : $e');
      printLog(trace);

      return VerifyModel();
    }
  }
}
