// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/repository/local_category_repository.dart';

class AddLocalCategory extends UsecaseWithParams<void, AddLocalCategoryParams> {
  AddLocalCategory(this._localCategoryRepository);

  final LocalCategoryRepository _localCategoryRepository;

  @override
  ResultFuture<void> call(AddLocalCategoryParams params) =>
      _localCategoryRepository.addLocalCategory(params.name);
}

class AddLocalCategoryParams extends Equatable {
  const AddLocalCategoryParams(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
