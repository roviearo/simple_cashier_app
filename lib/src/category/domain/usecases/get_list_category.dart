import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class GetListCategory extends UsecaseWithoutParams<List<Category>> {
  GetListCategory(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  ResultFuture<List<Category>> call() => _categoryRepository.getListCategory();
}
