import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:sqflite/sqflite.dart';

class GetLocalDatabase extends UsecaseWithoutParams<Database> {
  GetLocalDatabase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<Database> call() => _authenticationRepository.getLocalDatabase();
}
