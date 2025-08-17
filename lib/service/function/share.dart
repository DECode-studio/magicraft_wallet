// import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
// import 'package:flutter/services.dart';

// var _titleShare = 'BlockChat Share';

// Future<void> shareText({
//   required String text,
//   String? title,
// }) async =>
//     Share.text(
//       title ?? _titleShare,
//       text,
//       'text/plain',
//     );

// Future<void> shareFile({
//   required String fileName,
//   required Uint8List file,
//   String? title,
//   String? text,
//   String? fileType,
// }) async =>
//     Share.file(
//       title ?? _titleShare,
//       fileName,
//       file,
//       fileType ?? '*/*',
//       text: text ?? '',
//     );

// Future<void> shareFiles({
//   required Map<String, List<int>> files,
//   String? title,
//   String? text,
//   Set<String>? fileType,
// }) async =>
//     Share.files(
//       title ?? _titleShare,
//       files,
//       fileType ?? {'*/*'},
//       text: text ?? '',
//     );
