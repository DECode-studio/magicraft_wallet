import 'package:dompet_ku/controller/service/auth.dart';
import 'package:dompet_ku/controller/service/ethereum.dart';
import 'package:dompet_ku/model/api/main.dart';
import 'package:dompet_ku/model/api/request/verivy.dart';
import 'package:dompet_ku/model/api/response/verivy.dart';
import 'package:dompet_ku/service/config/api.dart';
import 'package:dompet_ku/service/formater/date.dart';
import 'package:dompet_ku/service/function/http_request.dart';
import 'package:dompet_ku/service/function/log.dart';
import 'package:dompet_ku/service/value/encrypt.dart';

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
