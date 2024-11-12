import 'package:dartz/dartz.dart';
import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/core/errors/failure.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/authentication/data/datasources/authentication_secure_storage_remote_data_source.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_secure_storage_repopsitory.dart';

class AuthenticationSecureStorageImplementation
    implements AuthenticationSecureStorageRepopsitory {
  AuthenticationSecureStorageImplementation(
      this._authenticationSecureStorageRemoteDataSource);

  final AuthenticationSecureStorageRemoteDataSource
      _authenticationSecureStorageRemoteDataSource;

  @override
  ResultFuture<String?> getAccessToken() async {
    try {
      final result =
          await _authenticationSecureStorageRemoteDataSource.getAccessToken();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveAccessToken(String? value) async {
    try {
      await _authenticationSecureStorageRemoteDataSource.saveAccessToken(value);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteAccessToken() async {
    try {
      await _authenticationSecureStorageRemoteDataSource.deleteAccessToken();

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
