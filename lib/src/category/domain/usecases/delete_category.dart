// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class DeleteCategory extends UsecaseWithParams<void, DeleteCategoryParams> {
  DeleteCategory(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  ResultFuture<void> call(DeleteCategoryParams params) =>
      _categoryRepository.deleteCategory(params.id);
}

class DeleteCategoryParams extends Equatable {
  const DeleteCategoryParams(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
