import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract class AuthenticationRepository {
  Stream<supabase.AuthState> authState();
  ResultFuture<supabase.User?> signIn(
      {required String email, required String password});
  ResultVoid signUp({required String email, required String password});
  ResultVoid signOut();
}
