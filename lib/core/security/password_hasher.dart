import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
class PasswordHasher {
  static const int _saltLength = 16;
  static const int _iterations = 10000;
  static String hashPassword(String password) {
    
    final salt = _generateSalt();
    
    
    final hash = _hashWithSalt(password, salt);
    
    
    final combined = Uint8List(_saltLength + hash.length)
      ..setRange(0, _saltLength, salt)
      ..setRange(_saltLength, _saltLength + hash.length, hash);
    
    return base64.encode(combined);
  }
  static bool verifyPassword(String password, String hashedPassword) {
    try {
      final combined = base64.decode(hashedPassword);
      
      if (combined.length < _saltLength) {
        return false;
      }
      
      
      final salt = combined.sublist(0, _saltLength);
      final storedHash = combined.sublist(_saltLength);
      
      
      final computedHash = _hashWithSalt(password, salt);
      
      
      return _constantTimeEquals(computedHash, storedHash);
    } catch (e) {
      return false;
    }
  }
  static Uint8List _generateSalt() {
    final random = DateTime.now().millisecondsSinceEpoch;
    final bytes = utf8.encode(random.toString());
    final hash = sha256.convert(bytes);
    return Uint8List.fromList(hash.bytes.sublist(0, _saltLength));
  }
  static Uint8List _hashWithSalt(String password, Uint8List salt) {
    final passwordBytes = utf8.encode(password);
    final hmac = Hmac(sha256, salt);
    final digest = hmac.convert(passwordBytes);
    
    
    var result = Uint8List.fromList(digest.bytes);
    for (var i = 0; i < _iterations - 1; i++) {
      final nextDigest = hmac.convert(result);
      result = Uint8List.fromList(nextDigest.bytes);
    }
    
    return result;
  }
  static bool _constantTimeEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }
}
