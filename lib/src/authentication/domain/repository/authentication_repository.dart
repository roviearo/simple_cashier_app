import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

abstract class AuthenticationRepository {
  Stream<supabase.AuthState> authState();
  ResultFuture<supabase.User?> signIn(
      {required String email, required String password});
  ResultFuture<supabase.User?> signUp(
      {required String email, required String password});
  ResultVoid signOut();
  ResultFuture<Database> getLocalDatabase();
}
