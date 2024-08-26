import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:life_sync/enum/enum.dart';
import 'package:life_sync/repositories/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(const AuthState()) {
    on<LoginButtonEvent>(_loginButtonEvent);
    on<SignUpButtonEvent>(_signUpButtonEvent);
    on<PasswordResetEvent>(_passwordResetEvent);
  }

  FutureOr<void> _loginButtonEvent(
      LoginButtonEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      await authRepo.userLogin(event.mail, event.pass);
      emit(state.copyWith(loginStatus: LoginStatus.success));
    } on IncorrectCredentailsAuthServicesException {
      emit(state.copyWith(loginStatus: LoginStatus.error));
    }
    // User? user = await authRepo.signInMethod(event.mail, event.pass);

    // if (user != null) {
    //   emit(state.copyWith(loginStatus: LoginStatus.success));

    // } else {
    //   emit(state.copyWith(loginStatus: LoginStatus.error));
    // }
  }

  FutureOr<void> _signUpButtonEvent(
      SignUpButtonEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));
    try {
      await authRepo.signUpMethod(event.fullname, event.email, event.password);
      emit(state.copyWith(registerStatus: RegisterStatus.success));
    } on IncorrectCredentailsAuthServicesException {
      emit(state.copyWith(registerStatus: RegisterStatus.error));
    }

    // bool user = await authRepo.signUpMethod(event.email, event.password,event.fullname);
    // if (user == true) {
    //   emit(state.copyWith(registerStatus: RegisterStatus.success));
    // } else {
    //   emit(state.copyWith(registerStatus: RegisterStatus.error));
    // }
  }

  FutureOr<void> _passwordResetEvent(
      PasswordResetEvent event, Emitter<AuthState> emit) async {
    await authRepo.passwordResetMethod(event.fmail);
  }
}
