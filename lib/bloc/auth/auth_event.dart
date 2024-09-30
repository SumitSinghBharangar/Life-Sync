part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonEvent extends AuthEvent {
  final int phone;

  const LoginButtonEvent({
    required this.phone,
  });

  @override
  List<Object> get props => [phone];
}
