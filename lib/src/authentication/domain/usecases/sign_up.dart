import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repository/authentication_repository.dart';

class SignUp extends UsecaseWithParams<supabase.User?, SignUpParams> {
  SignUp(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<supabase.User?> call(SignUpParams params) async =>
      _repository.signUp(
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
