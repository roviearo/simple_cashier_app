import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:simple_cashier_app/core/utils/database_helper.dart';
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
import 'package:simple_cashier_app/src/category/data/datasources/category_remote_data_source.dart';
import 'package:simple_cashier_app/src/category/data/repositories/category_repository_implementation.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/add_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/add_local_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/delete_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/get_list_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/get_local_list_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/sync_remote_to_local_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/update_category.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/add_category/add_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/delete_category/delete_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/list_category/list_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/update_category/update_category_cubit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:get_it/get_it.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/auth_state.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final db = await DatabaseHelper.initDb();

  sl
    ..registerFactory(() => AuthenticationBloc(
        authState: sl(),
        getAccessToken: sl(),
        saveAccessToken: sl(),
        deleteAccessToken: sl(),
        signIn: sl(),
        signOut: sl(),
        signUp: sl()))
    ..registerFactory(
        () => AddCategoryCubit(addCategory: sl(), addLocalCategory: sl()))
    ..registerFactory(() => DeleteCategoryCubit(deleteCategory: sl()))
    ..registerFactory(() => ListCategoryCubit(
          getListCategory: sl(),
          getLocalListCategory: sl(),
          syncRemoteToLocalCategory: sl(),
        ))
    ..registerFactory(() => UpdateCategoryCubit(updateCategory: sl()))

    // Usecases

    /* Authentication */
    ..registerLazySingleton(() => AuthState(sl()))
    ..registerLazySingleton(() => GetAccessToken(sl()))
    ..registerLazySingleton(() => SaveAccessToken(sl()))
    ..registerLazySingleton(() => DeleteAccessToken(sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => SignUp(sl()))

    /* Category */
    ..registerLazySingleton(() => AddCategory(sl()))
    ..registerLazySingleton(() => DeleteCategory(sl()))
    ..registerLazySingleton(() => GetListCategory(sl()))
    ..registerLazySingleton(() => UpdateCategory(sl()))
    ..registerLazySingleton(() => AddLocalCategory(sl()))
    ..registerLazySingleton(() => GetLocalListCategory(sl()))
    ..registerLazySingleton(() => SyncRemoteToLocalCategory(sl()))

    // Repositories

    /* Authentication */
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    ..registerLazySingleton<AuthenticationSecureStorageRepopsitory>(
        () => AuthenticationSecureStorageImplementation(sl()))

    /* Category */
    ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImplementation(sl()))

    // Data Sources

    /* Authentication */
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<AuthenticationSecureStorageRemoteDataSource>(
        () => AuthenticationSecureStorageDataSrcImpl(sl()))

    /* Category */
    ..registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSrcImpl(sl(), sl()))

    // External Dependencies
    ..registerLazySingleton(() => supabase.Supabase.instance.client.auth)
    ..registerLazySingleton(() => supabase.Supabase.instance.client)
    ..registerLazySingleton(() => db)
    ..registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage())
    ..isReady<Database>()
    ..isReady<FlutterSecureStorage>();
}
