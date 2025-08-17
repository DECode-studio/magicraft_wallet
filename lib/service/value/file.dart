import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dompet_ku/service/function/log.dart';
import 'package:universal_io/io.dart';

Image imageFromBase64String(
  String base64String,
) {
  return Image.memory(base64Decode(base64String));
}

Future<Uint8List?> captureImage(
  GlobalKey<State<StatefulWidget>> imageKey,
) async {
  final boundary =
      imageKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
  var image = await boundary.toImage(pixelRatio: 5);
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final pngBytes = byteData?.buffer.asUint8List();

  return pngBytes;
}

Uint8List dataFromBase64String(
  String base64String,
) {
  return base64Decode(base64String);
}

String base64String(
  Uint8List data,
) {
  return base64Encode(data);
}

Future<Uint8List?> fileToUint8List(
  File file,
) async {
  try {
    Uint8List bytes = await file.readAsBytes();
    return bytes;
  } catch (e) {
    printLog('Error converting File to Uint8List: $e');
    return null;
  }
}
