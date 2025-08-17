import 'package:url_launcher/url_launcher.dart';

Future<void> launchUri(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

Future<void> urlLauncher(String url) async {
  await launch(
    url,
  );
}

Future<void> uriLauncher(Uri uri) async {
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $uri';
  }
}
