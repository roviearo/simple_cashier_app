import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/update_category.dart';

part 'update_category_state.dart';
part 'update_category_cubit.freezed.dart';

enum UpdateCategoryStatus { initial, updating, updated, error }

class UpdateCategoryCubit extends Cubit<UpdateCategoryState> {
  UpdateCategoryCubit({
    required UpdateCategory updateCategory,
  })  : _updateCategory = updateCategory,
        super(const UpdateCategoryState.initial());

  final UpdateCategory _updateCategory;

  idChanged(int value) {
    emit(state.copyWith(id: value, status: UpdateCategoryStatus.initial));
  }

  nameChanged(String value) {
    emit(state.copyWith(name: value, status: UpdateCategoryStatus.initial));
  }

  updateCategory() async {
    emit(state.copyWith(status: UpdateCategoryStatus.updating));

    final result =
        await _updateCategory.call(UpdateCategoryParams(state.id, state.name));

    result.fold(
      (failure) => emit(state.copyWith(
          message: failure.message, status: UpdateCategoryStatus.error)),
      (_) => emit(state.copyWith(status: UpdateCategoryStatus.updated)),
    );
  }
}
