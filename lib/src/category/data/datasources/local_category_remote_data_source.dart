import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/src/category/data/models/category_model.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalCategoryRemoteDataSource {
  Future<List<Category>> getLocalListCategory();
  Future<void> addLocalCategory(String name);
}

class LocalCategoryRemoteDataSrcImpl implements LocalCategoryRemoteDataSource {
  LocalCategoryRemoteDataSrcImpl(this._database);

  final Database _database;

  @override
  Future<void> addLocalCategory(String name) async {
    try {
      await _database.insert('categories', {
        'name': name,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }

  @override
  Future<List<Category>> getLocalListCategory() async {
    try {
      final response = await _database.query('categories');

      return response.map((data) => CategoryModel.fromMap(data)).toList();
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }
}
