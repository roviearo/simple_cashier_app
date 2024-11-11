import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repository/authentication_repository.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  SignUp(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) async => _repository.signUp(
        email: params.email,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams.empty()
      : this(
          email: '_empty.string',
          password: '_empty.string',
        );
  const SignUpParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
