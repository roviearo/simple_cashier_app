import 'package:equatable/equatable.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class AddLocalCategory extends UsecaseWithParams<void, AddLocalCategoryParams> {
  AddLocalCategory(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  ResultFuture<void> call(AddLocalCategoryParams params) =>
      _categoryRepository.addLocalCategory(params.name);
}

class AddLocalCategoryParams extends Equatable {
  const AddLocalCategoryParams(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
