import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract class AuthenticationRemoteDataSource {
  Stream<supabase.AuthState> authState();
  Future<supabase.User?> signIn(
      {required String email, required String password});
  Future<supabase.User?> signUp(
      {required String email, required String password});
  Future<void> signOut();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  AuthRemoteDataSrcImpl(this._auth);

  final supabase.GoTrueClient _auth;

  @override
  Future<supabase.User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user;
    } on supabase.AuthException catch (e) {
      throw APIException(
          message: e.message,
          statusCode: int.parse(e.statusCode!),
          errorCode: e.code);
    }
  }

  @override
  Future<supabase.User?> signUp(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signUp(
        email: email,
        password: password,
      );

      return response.user;
    } on supabase.AuthException catch (e) {
      throw APIException(
          message: e.message,
          statusCode: int.parse(e.statusCode!),
          errorCode: e.code);
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Stream<supabase.AuthState> authState() {
    return _auth.onAuthStateChange;
  }
}
