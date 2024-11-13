part of 'delete_category_cubit.dart';

@freezed
class DeleteCategoryState with _$DeleteCategoryState {
  const factory DeleteCategoryState.initial({
    @Default(0) int id,
    @Default('') String message,
    @Default(DeleteCategoryStatus.initial) DeleteCategoryStatus status,
  }) = Initial;
}
