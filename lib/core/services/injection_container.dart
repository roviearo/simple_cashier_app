import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:simple_cashier_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:simple_cashier_app/src/authentication/data/datasources/authentication_secure_storage_remote_data_source.dart';
import 'package:simple_cashier_app/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:simple_cashier_app/src/authentication/data/repositories/authentication_secure_storage_implementation.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_secure_storage_repopsitory.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/delete_access_token.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/get_access_token.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/save_access_token.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/sign_out.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:get_it/get_it.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/auth_state.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthenticationBloc(
        authState: sl(),
        getAccessToken: sl(),
        saveAccessToken: sl(),
        deleteAccessToken: sl(),
        signIn: sl(),
        signOut: sl(),
        signUp: sl()))

    // Usecases

    /* Authentication */
    ..registerLazySingleton(() => AuthState(sl()))
    ..registerLazySingleton(() => GetAccessToken(sl()))
    ..registerLazySingleton(() => SaveAccessToken(sl()))
    ..registerLazySingleton(() => DeleteAccessToken(sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => SignUp(sl()))

    // Repositories

    /* Authentication */
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    ..registerLazySingleton<AuthenticationSecureStorageRepopsitory>(
        () => AuthenticationSecureStorageImplementation(sl()))

    // Data Sources

    /* Authentication */
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<AuthenticationSecureStorageDataSrcImpl>(
        () => AuthenticationSecureStorageDataSrcImpl())

    // External Dependencies
    ..registerLazySingleton(() => supabase.Supabase.instance.client.auth)
    ..registerLazySingleton(() => supabase.Supabase.instance.client)
    ..isReady<FlutterSecureStorage>();
}
