import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';

void fullScreenInterface() {
  if (GetPlatform.isAndroid) {
    try {
      if (kDebugMode) {
        print('full screen interface');
      }

      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );

      if (kDebugMode) {
        print('full screen interface');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

void normalScreenInterface({
  required Color navBarColor,
  required Brightness brightNessColor,
}) {
  if (GetPlatform.isAndroid) {
    try {
      if (kDebugMode) {
        print('normal screen interface');
      }

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: navBarColor,
          systemNavigationBarIconBrightness: brightNessColor,
        ),
      );

      if (kDebugMode) {
        print('normal screen interface');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
