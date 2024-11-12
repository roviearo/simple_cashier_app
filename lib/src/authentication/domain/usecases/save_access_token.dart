import 'package:equatable/equatable.dart';

import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_secure_storage_repopsitory.dart';

class SaveAccessToken extends UsecaseWithParams<void, SaveAccessTokenParams> {
  SaveAccessToken(this._authenticationSecureStorageRepopsitory);

  final AuthenticationSecureStorageRepopsitory
      _authenticationSecureStorageRepopsitory;

  @override
  ResultFuture<void> call(SaveAccessTokenParams params) =>
      _authenticationSecureStorageRepopsitory.saveAccessToken(params.value);
}

class SaveAccessTokenParams extends Equatable {
  const SaveAccessTokenParams({required this.value});

  final String? value;

  @override
  List<Object?> get props => [value];
}
