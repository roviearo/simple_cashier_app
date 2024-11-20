import 'package:dartz/dartz.dart';
import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/core/errors/failure.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/data/datasources/category_remote_data_source.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class CategoryRepositoryImplementation implements CategoryRepository {
  CategoryRepositoryImplementation(this._categoryRemoteDataSource);

  final CategoryRemoteDataSource _categoryRemoteDataSource;

  @override
  ResultVoid addCategory(String name) async {
    try {
      await _categoryRemoteDataSource.addCategory(name);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteCategory(int id) async {
    try {
      await _categoryRemoteDataSource.deleteCategory(id);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Category>> getListCategory() async {
    try {
      final result = await _categoryRemoteDataSource.getListCategory();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateCategory(int id, String name) async {
    try {
      await _categoryRemoteDataSource.updateCategory(id, name);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid addLocalCategory(String name) async {
    try {
      await _categoryRemoteDataSource.addLocalCategory(name);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Category>> getLocalListCategory() async {
    try {
      final result = await _categoryRemoteDataSource.getLocalListCategory();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid syncRemoteToLocal() async {
    try {
      await _categoryRemoteDataSource.syncRemoteToLocal();

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
