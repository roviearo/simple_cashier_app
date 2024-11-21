import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/get_list_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/get_local_list_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/sync_remote_to_local_category.dart';

part 'list_category_state.dart';
part 'list_category_cubit.freezed.dart';

enum ListCategoryStatus { initial, loading, loaded, error }

class ListCategoryCubit extends Cubit<ListCategoryState> {
  ListCategoryCubit({
    required GetListCategory getListCategory,
    required GetLocalListCategory getLocalListCategory,
    required SyncRemoteToLocalCategory syncRemoteToLocalCategory,
  })  : _getListCategory = getListCategory,
        _getLocalListCategory = getLocalListCategory,
        _syncRemoteToLocalCategory = syncRemoteToLocalCategory,
        super(const ListCategoryState.initial());

  final GetListCategory _getListCategory;
  final GetLocalListCategory _getLocalListCategory;
  final SyncRemoteToLocalCategory _syncRemoteToLocalCategory;

  syncToLocalCategory() async {
    await _syncRemoteToLocalCategory.call();
  }

  getListCategory() async {
    emit(state.copyWith(status: ListCategoryStatus.loading));

    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      final result = await _getListCategory.call();

      result.fold(
        (failure) => emit(state.copyWith(
            message: failure.message, status: ListCategoryStatus.error)),
        (listCategory) => emit(state.copyWith(
            listCategory: listCategory, status: ListCategoryStatus.loaded)),
      );
    } else {
      final result = await _getLocalListCategory.call();

      result.fold(
        (failure) => emit(state.copyWith(
            message: failure.message, status: ListCategoryStatus.error)),
        (listCategory) => emit(state.copyWith(
            listCategory: listCategory, status: ListCategoryStatus.loaded)),
      );
    }
  }
}
