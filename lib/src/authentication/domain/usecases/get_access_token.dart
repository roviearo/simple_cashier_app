import 'package:simple_cashier_app/core/usecase/usecase.dart';
import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/authentication/domain/repository/authentication_secure_storage_repopsitory.dart';

class GetAccessToken extends UsecaseWithoutParams<String?> {
  GetAccessToken(this._authenticationSecureStorageRepopsitory);

  final AuthenticationSecureStorageRepopsitory
      _authenticationSecureStorageRepopsitory;

  @override
  ResultFuture<String?> call() =>
      _authenticationSecureStorageRepopsitory.getAccessToken();
}
