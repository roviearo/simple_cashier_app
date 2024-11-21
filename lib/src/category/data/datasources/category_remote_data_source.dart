import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/src/category/data/models/category_model.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getListCategory();
  Future<void> addCategory(String name);
  Future<void> deleteCategory(int id);
  Future<void> updateCategory(int id, String name);
  Future<List<Category>> getLocalListCategory();
  Future<void> addLocalCategory(String name);
  Future<void> syncRemoteToLocal();
}

class CategoryRemoteDataSrcImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSrcImpl(this._supabaseClient, this._database);

  final SupabaseClient _supabaseClient;
  final Database _database;

  @override
  Future<void> addCategory(String name) async {
    try {
      await _supabaseClient.from('categories').insert({
        'name': name,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await _supabaseClient.from('categories').delete().match({'id': id});
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }

  @override
  Future<List<Category>> getListCategory() async {
    try {
      final response = await _supabaseClient
          .from('categories')
          .select()
          .order('name', ascending: true);

      final data = response.map((data) => CategoryModel.fromMap(data)).toList();

      return data;
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    try {
      await _supabaseClient
          .from('categories')
          .update({'name': name}).eq('id', id);
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }

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
      final response = await _database.query('categories', orderBy: 'name');

      return response.map((data) => CategoryModel.fromMap(data)).toList();
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }

  @override
  Future<void> syncRemoteToLocal() async {
    try {
      final localCategories = await getLocalListCategory();
      final remoteCategories = await getListCategory();

      if (localCategories.isEmpty) {
        final batch = _database.batch();
        for (var category in remoteCategories) {
          batch.insert('categories', category.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit();
      }

      for (var localCategory in localCategories) {
        final Category? remoteCategory = remoteCategories
            .where((category) => category.id == localCategory.id)
            .firstOrNull;

        if (remoteCategory == null) {
          await _supabaseClient
              .from('categories')
              .insert(localCategory.toMap());
        } else if (localCategory.updatedAt.isAfter(remoteCategory.updatedAt)) {
          await _supabaseClient
              .from('categories')
              .upsert(localCategory.toMap())
              .eq('id', remoteCategory.id);
          await _database.update('categories', remoteCategory.toMap(),
              where: 'id = ?', whereArgs: [localCategory.id]);
        } else if (remoteCategory.updatedAt.isAfter(localCategory.updatedAt)) {
          await _database.update('categories', {'is_synced': 1},
              where: 'id = ?', whereArgs: [localCategory.id]);
        }
      }
    } on APIException catch (e) {
      throw APIException(message: e.message, statusCode: 505);
    }
  }
}
