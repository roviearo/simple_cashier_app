import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/add_category.dart';

part 'add_category_state.dart';
part 'add_category_cubit.freezed.dart';

enum AddCategoryStatus { initial, submitting, success, error }

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit({
    required AddCategory addCategory,
  })  : _addCategory = addCategory,
        super(const AddCategoryState.initial());

  final AddCategory _addCategory;

  clearAddCategory() {
    emit(const AddCategoryState.initial());
  }

  nameChanged(String value) {
    emit(state.copyWith(name: value, status: AddCategoryStatus.initial));
  }

  addCategory() async {
    emit(state.copyWith(status: AddCategoryStatus.submitting));

    if (state.name.isNotEmpty) {
      final result = await _addCategory.call(AddCategoryParams(state.name));

      result.fold(
        (failure) => emit(state.copyWith(
            message: failure.message, status: AddCategoryStatus.error)),
        (_) => emit(state.copyWith(status: AddCategoryStatus.success)),
      );
    }
  }
}
