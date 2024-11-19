import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:simple_cashier_app/src/category/domain/repository/local_category_repository.dart';

class GetLocalListCategory extends UsecaseWithoutParams<List<Category>> {
  GetLocalListCategory(this._localCategoryRepository);

  final LocalCategoryRepository _localCategoryRepository;

  @override
  ResultFuture<List<Category>> call() =>
      _localCategoryRepository.getLocalListCategory();
}
