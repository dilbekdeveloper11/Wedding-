import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

abstract class _Keys {
  static const String tokenId = 'token-id';
}

class TokenDataProvider {
  static const _secureStorage = FlutterSecureStorage();
   final box = GetStorage();


  Future<String?> getTokenId() => _secureStorage.read(key: _Keys.tokenId);

  Future<void> setTokenId(String value) =>
      _secureStorage.write(key: _Keys.tokenId, value: value);
}
