part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String email;
  final RegisterStatus registerStatus;
  final LoginStatus loginStatus;
  final String mail;
  final String pass;
  final String password;
  final String fmail;
  final String loginmsg;
  final String signupmsg;
  const AuthState({
    this.pass = '',
    this.password = '',
    this.email = '',
    this.mail = '',
    this.fmail = '',
    this.loginmsg = "",
    this.signupmsg = "",
    this.loginStatus = LoginStatus.initail,
    this.registerStatus = RegisterStatus.initail,
  });

  AuthState copyWith({
    String? mail,
    String? fmail,
    String? email,
    String? pass,
    String? password,
    String? loginmsg,
    String? signupmsg,
    LoginStatus? loginStatus,
    RegisterStatus? registerStatus,
  }) {
    return AuthState(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      mail: mail ?? this.mail,
      fmail: fmail ?? this.fmail,
      password: password ?? this.password,
      loginmsg: loginmsg ?? this.loginmsg,
      signupmsg: signupmsg ?? this.signupmsg,
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
    );
  }

  @override
  List<Object> get props => [
        mail,
        email,
        pass,
        password,
        loginStatus,
        registerStatus,
        fmail,
        loginmsg,
        signupmsg,
      ];
}
