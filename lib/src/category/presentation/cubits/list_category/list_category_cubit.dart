import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:simple_cashier_app/src/category/domain/usecases/get_list_category.dart';

part 'list_category_state.dart';
part 'list_category_cubit.freezed.dart';

enum ListCategoryStatus { initial, loading, loaded, error }

class ListCategoryCubit extends Cubit<ListCategoryState> {
  ListCategoryCubit({
    required GetListCategory getListCategory,
  })  : _getListCategory = getListCategory,
        super(const ListCategoryState.initial());

  final GetListCategory _getListCategory;

  getListCategory() async {
    emit(state.copyWith(status: ListCategoryStatus.loading));

    final result = await _getListCategory.call();

    result.fold(
      (failure) => emit(state.copyWith(
          message: failure.message, status: ListCategoryStatus.error)),
      (listCategory) => emit(state.copyWith(
          listCategory: listCategory, status: ListCategoryStatus.loaded)),
    );
  }
}
