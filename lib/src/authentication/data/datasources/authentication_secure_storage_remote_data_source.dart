import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/core/utils/constants.dart';

abstract class AuthenticationSecureStorageRemoteDataSource {
  Future<void> saveAccessToken(String? value);
  Future<void> deleteAccessToken();
  Future<String?> getAccessToken();
}

class AuthenticationSecureStorageDataSrcImpl
    implements AuthenticationSecureStorageRemoteDataSource {
  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> getAccessToken() async {
    try {
      final accessToken = await _storage.read(key: Constants.accessToken);

      return accessToken;
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> saveAccessToken(String? value) async {
    try {
      await _storage.write(key: Constants.accessToken, value: value);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<void> deleteAccessToken() async {
    try {
      await _storage.delete(key: Constants.accessToken);
    } on APIException catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
