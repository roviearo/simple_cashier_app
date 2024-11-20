import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';

abstract class CategoryRepository {
  ResultFuture<List<Category>> getListCategory();
  ResultVoid addCategory(String name);
  ResultVoid deleteCategory(int id);
  ResultVoid updateCategory(int id, String name);
  ResultFuture<List<Category>> getLocalListCategory();
  ResultVoid addLocalCategory(String name);
  ResultVoid syncRemoteToLocal();
}
