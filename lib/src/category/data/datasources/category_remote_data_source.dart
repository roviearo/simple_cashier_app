import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/src/category/data/models/category_model.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getListCategory();
  Future<void> addCategory(String name);
  Future<void> deleteCategory(int id);
  Future<void> updateCategory(int id, String name);
}

class CategoryRemoteDataSrcImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSrcImpl(this._supabaseClient);

  final SupabaseClient _supabaseClient;

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
}
