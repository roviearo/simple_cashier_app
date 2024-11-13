// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class UpdateCategory extends UsecaseWithParams<void, UpdateCategoryParams> {
  UpdateCategory(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  ResultFuture<void> call(UpdateCategoryParams params) =>
      _categoryRepository.updateCategory(params.id, params.name);
}

class UpdateCategoryParams extends Equatable {
  const UpdateCategoryParams(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
