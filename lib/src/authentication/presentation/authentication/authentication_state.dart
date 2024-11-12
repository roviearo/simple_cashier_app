part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.unauthenticated() = Unauthenticated;
  const factory AuthenticationState.offlineAuthenticated() =
      OfflineAuthenticated;
  const factory AuthenticationState.authenticated() = Authenticated;
  const factory AuthenticationState.signedOut() = SignedOut;
  const factory AuthenticationState.authenticationError(
      String message, String? errorCode) = AuthenticationError;
  const factory AuthenticationState.loading() = Loading;
}
