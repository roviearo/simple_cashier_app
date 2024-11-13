part of 'list_category_cubit.dart';

@freezed
class ListCategoryState with _$ListCategoryState {
  const factory ListCategoryState.initial({
    @Default([]) List<Category> listCategory,
    @Default('') message,
    @Default(ListCategoryStatus.initial) ListCategoryStatus status,
  }) = Initial;
}
