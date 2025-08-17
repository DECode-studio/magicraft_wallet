import 'package:clipboard/clipboard.dart';
import 'package:magicraft_wallet/widget/message/toast.dart';

Future<void> copyText({
  required String data,
  String? message,
}) async {
  await FlutterClipboard.copy(data).then((_) {
    successToast(message ?? 'text has been copied');
  });
}
