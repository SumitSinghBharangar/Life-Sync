part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String email;
  final RegisterStatus registerStatus;
  final LoginStatus loginStatus;
  final String mail;
  final String pass;
  final String password;
  const AuthState({
    this.pass = '',
    this.password = '',
    this.email = '',
    this.mail = '',
    this.loginStatus = LoginStatus.initail,
    this.registerStatus = RegisterStatus.initail,
  });

  AuthState copyWith({
    String? mail,
    String? email,
    String? pass,
    String? password,
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
  }) {
    return AuthState(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
    );
  }

  @override
  List<Object> get props => [mail,email,pass,password,loginStatus,registerStatus];
}


