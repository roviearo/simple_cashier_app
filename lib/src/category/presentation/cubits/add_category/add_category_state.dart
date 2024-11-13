part of 'add_category_cubit.dart';

@freezed
class AddCategoryState with _$AddCategoryState {
  const factory AddCategoryState.initial({
    @Default('') String name,
    @Default('') String message,
    @Default(AddCategoryStatus.initial) AddCategoryStatus status,
  }) = Initial;
}
