import 'package:dartz/dartz.dart';
import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/core/errors/failure.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:simple_cashier_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  AuthenticationRepositoryImplementation(this._authenticationRemoteDataSource);

  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  @override
  Stream<supabase.AuthState> authState() {
    return _authenticationRemoteDataSource.authState();
  }

  @override
  ResultFuture<supabase.User?> signIn(
      {required String email, required String password}) async {
    try {
      final result = await _authenticationRemoteDataSource.signIn(
          email: email, password: password);

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid signOut() async {
    try {
      await _authenticationRemoteDataSource.signOut();

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid signUp({required String email, required String password}) async {
    try {
      await _authenticationRemoteDataSource.signUp(
          email: email, password: password);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
