part of 'update_category_cubit.dart';

@freezed
class UpdateCategoryState with _$UpdateCategoryState {
  const factory UpdateCategoryState.initial({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String message,
    @Default(UpdateCategoryStatus.initial) UpdateCategoryStatus status,
  }) = Initial;
}
