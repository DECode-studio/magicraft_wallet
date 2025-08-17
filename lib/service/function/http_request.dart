import 'package:magicraft_wallet/controller/service/auth.dart';
import 'package:magicraft_wallet/service/value/encrypt.dart';
import 'package:http/http.dart';
import 'package:universal_io/io.dart';

class HttpRequest {
  final encrypt = EncryptValue();

  Future<Response> GET({
    required String url,
    String? token,
  }) {
    final session = AuthAppController.getSession();
    final authToken =
        'Bearer ${encrypt.decryptData(session.token ?? token ?? '')}';

    return get(
      Uri.parse(url),
      headers: {
        'Authorization': authToken,
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<Response> POST({
    required String url,
    dynamic req,
    bool? isJson,
    bool? isFormField,
  }) async {
    final session = AuthAppController.getSession();
    final uri = Uri.parse(url);

    final headers = {
      if (isJson == true) 'Content-Type': 'application/json',
      if (isFormField == true)
        'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${encrypt.decryptData(session.token ?? '')}',
    };

    if (req is Map<String, dynamic> && req.values.any((v) => v is File)) {
      final request = MultipartRequest('POST', uri)..headers.addAll(headers);

      for (var entry in req.entries) {
        if (entry.value is File) {
          final file = entry.value as File;
          request.files.add(await MultipartFile.fromPath(
            entry.key,
            file.path,
          ));
        } else {
          request.fields[entry.key] = entry.value.toString();
        }
      }

      final streamed = await request.send();
      return Response.fromStream(streamed);
    } else {
      return post(
        uri,
        headers: headers,
        body: req,
      );
    }
  }

  // ignore: non_constant_identifier_names
  Future<Response> EDIT({
    required String url,
    dynamic req,
    bool? isJson,
    bool? isFormField,
  }) async {
    final session = AuthAppController.getSession();
    final uri = Uri.parse(url);

    final headers = {
      if (isJson == true) 'Content-Type': 'application/json',
      if (isFormField == true)
        'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${encrypt.decryptData(session.token ?? '')}',
    };

    if (req is Map<String, dynamic> && req.values.any((v) => v is File)) {
      final request = MultipartRequest('PUT', uri)..headers.addAll(headers);

      for (var entry in req.entries) {
        if (entry.value is File) {
          final file = entry.value as File;
          request.files.add(await MultipartFile.fromPath(
            entry.key,
            file.path,
          ));
        } else {
          request.fields[entry.key] = entry.value.toString();
        }
      }

      final streamed = await request.send();
      return Response.fromStream(streamed);
    } else {
      return put(
        uri,
        headers: headers,
        body: req,
      );
    }
  }

  // ignore: non_constant_identifier_names
  Future<Response> PATCH({
    required String url,
    dynamic req,
    bool? isJson,
    bool? isFormField,
  }) async {
    final session = AuthAppController.getSession();
    final uri = Uri.parse(url);

    final headers = {
      if (isJson == true) 'Content-Type': 'application/json',
      if (isFormField == true)
        'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${encrypt.decryptData(session.token ?? '')}',
    };

    if (req is Map<String, dynamic> && req.values.any((v) => v is File)) {
      final request = MultipartRequest('PATCH', uri)..headers.addAll(headers);

      for (var entry in req.entries) {
        if (entry.value is File) {
          final file = entry.value as File;
          request.files.add(await MultipartFile.fromPath(
            entry.key,
            file.path,
          ));
        } else {
          request.fields[entry.key] = entry.value.toString();
        }
      }

      final streamed = await request.send();
      return Response.fromStream(streamed);
    } else {
      return patch(
        uri,
        headers: headers,
        body: req,
      );
    }
  }

  Future<Response> DELETE({
    required String url,
    dynamic req,
  }) {
    final session = AuthAppController.getSession();
    return delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${encrypt.decryptData(session.token ?? '')}',
      },
      body: req,
    );
  }
}
