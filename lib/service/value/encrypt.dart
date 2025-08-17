import 'package:encrypt/encrypt.dart';
import 'package:dompet_ku/service/function/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

class EncryptValue {
  final uuid = const Uuid();
  final APP_ENCRYPT_KEY = dotenv.env['APP_ENCRYPT_KEY'] ?? '';

  IV _iv() {
    final iv = IV.fromUtf8(APP_ENCRYPT_KEY);
    return iv;
  }

  Encrypter _encrypter() {
    final encrypter = Encrypter(
      AES(
        Key.fromUtf8(APP_ENCRYPT_KEY),
        mode: AESMode.cbc,
      ),
    );

    return encrypter;
  }

  String encryptData(String text) {
    try {
      final encrypted = _encrypter().encrypt(text, iv: _iv());

      return encrypted.base64;
    } catch (e) {
      printLog('error encrypt: $e');
      return text;
    }
  }

  String decryptData(String text) {
    try {
      final encrypted = Encrypted.fromBase64(text);
      final decrypted = _encrypter().decrypt(encrypted, iv: _iv());

      return decrypted.toString();
    } catch (e) {
      printLog('error decrypt: $e');
      return text;
    }
  }
}
