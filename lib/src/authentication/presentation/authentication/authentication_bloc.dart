import 'package:simple_cashier_app/src/authentication/domain/usecases/auth_state.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/delete_access_token.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/get_access_token.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/save_access_token.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/sign_out.dart';
import 'package:simple_cashier_app/src/authentication/domain/usecases/sign_up.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthState authState,
    required GetAccessToken getAccessToken,
    required SaveAccessToken saveAccessToken,
    required DeleteAccessToken deleteAccessToken,
    required SignIn signIn,
    required SignOut signOut,
    required SignUp signUp,
  })  : _getAccessToken = getAccessToken,
        _saveAccessToken = saveAccessToken,
        _deleteAccessToken = deleteAccessToken,
        _signIn = signIn,
        _signOut = signOut,
        _signUp = signUp,
        super(const Unauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<SignOutEvent>(_onSignOutEvent);

    authState.call().listen((data) {
      add(AuthUserChanged(data.event, data.session));
    });
  }
  supabase.AuthChangeEvent? authChangeEvent;
  supabase.Session? session;

  final GetAccessToken _getAccessToken;
  final SaveAccessToken _saveAccessToken;
  final DeleteAccessToken _deleteAccessToken;
  final SignIn _signIn;
  final SignOut _signOut;
  final SignUp _signUp;

  _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
    } else {
      final result = await _getAccessToken.call();

      result.fold(
        (failure) =>
            emit(AuthenticationError(failure.message, failure.errorCode)),
        (accessToken) => accessToken != null
            ? emit(const OfflineAuthenticated())
            : emit(const Unauthenticated()),
      );
    }
  }

  _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthenticationState> emit) async {
    if (event.session?.accessToken != null) {
      _saveAccessToken
          .call(SaveAccessTokenParams(value: event.session?.accessToken));
      emit(const Authenticated());
    } else {
      emit(const Unauthenticated());
    }
  }

  _onSignInEvent(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const Loading());

    final result = await _signIn
        .call(SignInParams(email: event.email, password: event.password));

    result.fold(
      (failure) =>
          emit(AuthenticationError(failure.message, failure.errorCode)),
      (user) {
        emit(const Authenticated());
      },
    );
  }

  _onSignUpEvent(
    SignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const Loading());

    final result = await _signUp
        .call(SignUpParams(email: event.email, password: event.password));

    result.fold(
      (failure) =>
          emit(AuthenticationError(failure.message, failure.errorCode)),
      (user) {
        emit(const Authenticated());
      },
    );
  }

  _onSignOutEvent(
    SignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const Loading());

    final result = await _signOut();

    result.fold(
      (failure) => failure.errorMessage,
      (r) {
        _deleteAccessToken.call();
        emit(const SignedOut());
      },
    );
  }
}
