part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.appStarted() = AppStarted;
  const factory AuthenticationEvent.authUserChanged(
      supabase.AuthChangeEvent? authChangeEvent,
      supabase.Session? session) = AuthUserChanged;
  const factory AuthenticationEvent.signInEvent(String email, String password) =
      SignInEvent;
  const factory AuthenticationEvent.signUpEvent(String email, String password) =
      SignUpEvent;
  const factory AuthenticationEvent.signOutEvent() = SignOutEvent;
}
