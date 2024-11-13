// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class AddCategory extends UsecaseWithParams<void, AddCategoryParams> {
  AddCategory(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  ResultFuture<void> call(AddCategoryParams params) =>
      _categoryRepository.addCategory(params.name);
}

class AddCategoryParams extends Equatable {
  const AddCategoryParams(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
