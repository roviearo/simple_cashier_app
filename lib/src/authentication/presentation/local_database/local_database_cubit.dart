import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/get_local_database.dart';
import 'package:sqflite/sqflite.dart';

part 'local_database_state.dart';
part 'local_database_cubit.freezed.dart';

enum LocalDatabaseStatus { initial, loading, loaded, error }

class LocalDatabaseCubit extends Cubit<LocalDatabaseState> {
  LocalDatabaseCubit({
    required GetLocalDatabase getLocalDatabase,
  })  : _getLocalDatabase = getLocalDatabase,
        super(LocalDatabaseState.initial());

  final GetLocalDatabase _getLocalDatabase;

  loadLocalDatabase() async {
    emit(state.copyWith(status: LocalDatabaseStatus.loading));

    final result = await _getLocalDatabase.call();

    result.fold(
      (failure) => emit(state.copyWith(
          message: failure.message, status: LocalDatabaseStatus.error)),
      (database) => emit(state.copyWith(
          database: database, status: LocalDatabaseStatus.loaded)),
    );
  }
}
