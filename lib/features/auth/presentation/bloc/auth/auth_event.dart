part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class SignIn extends AuthEvent {
  final String email;

  SignIn(this.email);
}
