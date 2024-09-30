part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final int? phone;
  final bool isLoading;

  const AuthState({
    this.phone,
    this.isLoading = false,
  });

  AuthState copyWith({
    int? phone,
    bool? isLoading,
  }) {
    return AuthState(
      phone: this.phone,
      isLoading: this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        phone!,
        isLoading,
      ];
}
