import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/add_category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/add_local_category.dart';

part 'add_category_state.dart';
part 'add_category_cubit.freezed.dart';

enum AddCategoryStatus { initial, submitting, success, error }

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit({
    required AddCategory addCategory,
    required AddLocalCategory addLocalCategory,
  })  : _addCategory = addCategory,
        _addLocalCategory = addLocalCategory,
        super(const AddCategoryState.initial());

  final AddCategory _addCategory;
  final AddLocalCategory _addLocalCategory;

  clearAddCategory() {
    emit(const AddCategoryState.initial());
  }

  nameChanged(String value) {
    emit(state.copyWith(name: value, status: AddCategoryStatus.initial));
  }

  addCategory() async {
    emit(state.copyWith(status: AddCategoryStatus.submitting));

    final connectivityResult = await Connectivity().checkConnectivity();

    if (state.name.isNotEmpty) {
      final result =
          await _addLocalCategory.call(AddLocalCategoryParams(state.name));

      result.fold(
        (failure) => emit(state.copyWith(
            message: failure.message, status: AddCategoryStatus.error)),
        (_) async {
          if (connectivityResult.contains(ConnectivityResult.mobile) ||
              connectivityResult.contains(ConnectivityResult.wifi)) {
            final result =
                await _addCategory.call(AddCategoryParams(state.name));

            result.fold(
              (failure) => emit(state.copyWith(
                  message: failure.message, status: AddCategoryStatus.error)),
              (_) => emit(state.copyWith(status: AddCategoryStatus.success)),
            );
          } else {
            emit(state.copyWith(status: AddCategoryStatus.success));
          }
        },
      );
    }
  }
}
