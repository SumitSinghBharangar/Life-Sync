part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonEvent extends AuthEvent {
  final String mail;
  final String pass;

  const LoginButtonEvent({required this.mail, required this.pass});

  @override
  List<Object> get props => [pass, mail];
}

class SignUpButtonEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullname;

  const SignUpButtonEvent({required this.email, required this.password,required this.fullname,});

  @override
  List<Object> get props => [password, email,fullname];
}

class PasswordResetEvent extends AuthEvent {
  final String fmail;

  const PasswordResetEvent({required this.fmail});
  @override
  List<Object> get props => [fmail];

}
