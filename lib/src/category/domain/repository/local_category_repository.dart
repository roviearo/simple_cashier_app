import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';

abstract class LocalCategoryRepository {
  ResultFuture<List<Category>> getLocalListCategory();
  ResultVoid addLocalCategory(String name);
}
