import 'package:simple_cashier_app/core/utils/typedef.dart';

abstract class AuthenticationSecureStorageRepopsitory {
  ResultVoid saveAccessToken(String value);
  ResultFuture<String> getAccessToken();
}
