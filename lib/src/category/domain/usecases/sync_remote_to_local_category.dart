import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/repository/category_repository.dart';

class SyncRemoteToLocalCategory extends UsecaseWithoutParams<void> {
  SyncRemoteToLocalCategory(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  ResultFuture<void> call() => _categoryRepository.syncRemoteToLocal();
}
