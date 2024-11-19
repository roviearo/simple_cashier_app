import 'package:dartz/dartz.dart';
import 'package:simple_cashier_app/core/errors/exception.dart';
import 'package:simple_cashier_app/core/errors/failure.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/data/datasources/local_category_remote_data_source.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';
import 'package:simple_cashier_app/src/category/domain/repository/local_category_repository.dart';

class LocalCategoryRepositoryImplementation implements LocalCategoryRepository {
  LocalCategoryRepositoryImplementation(this._localCategoryRemoteDataSource);

  final LocalCategoryRemoteDataSource _localCategoryRemoteDataSource;

  @override
  ResultVoid addLocalCategory(String name) async {
    try {
      await _localCategoryRemoteDataSource.addLocalCategory(name);

      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Category>> getLocalListCategory() async {
    try {
      final result =
          await _localCategoryRemoteDataSource.getLocalListCategory();

      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
