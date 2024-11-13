import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/delete_category.dart';

part 'delete_category_state.dart';
part 'delete_category_cubit.freezed.dart';

enum DeleteCategoryStatus { initial, deleting, deleted, error }

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  DeleteCategoryCubit({
    required DeleteCategory deleteCategory,
  })  : _deleteCategory = deleteCategory,
        super(const DeleteCategoryState.initial());

  final DeleteCategory _deleteCategory;

  deleteCategory(int id) async {
    emit(state.copyWith(status: DeleteCategoryStatus.deleting));

    final result = await _deleteCategory.call(DeleteCategoryParams(id));

    result.fold(
      (failure) => emit(state.copyWith(
          message: failure.message, status: DeleteCategoryStatus.error)),
      (_) => emit(state.copyWith(status: DeleteCategoryStatus.deleted)),
    );
  }
}
