part of 'local_database_cubit.dart';

@freezed
class LocalDatabaseState with _$LocalDatabaseState {
  factory LocalDatabaseState.initial({
    Database? database,
    @Default('') message,
    @Default(LocalDatabaseStatus.initial) LocalDatabaseStatus status,
  }) = Initial;
}
