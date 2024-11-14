import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:sqflite/sqflite.dart';

class InitDb extends UsecaseWithoutParams<Database> {
  InitDb(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<Database> call() => _authenticationRepository.call();
}
