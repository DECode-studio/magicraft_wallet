import 'package:flutter_dotenv/flutter_dotenv.dart';

final ICON_APP_URL = dotenv.env['ICON_APP_URL'] ?? '';
final MAIN_APP_URL = dotenv.env['MAIN_APP_URL'] ?? '';
final DEEP_LINK_URL = dotenv.env['DEEP_LINK_URL'] ?? '';
final WEB_APP_URL = dotenv.env['WEB_APP_URL'] ?? '';
