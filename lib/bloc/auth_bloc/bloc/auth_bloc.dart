import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_sync/enum/enum.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginButtonEvent>(_LoginButtonEvent);
    on<SignUpButtonEvent>(_SignUpButtonEvent)
  }

  FutureOr<void> _LoginButtonEvent(LoginButtonEvent event, Emitter<AuthState> emit)async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    User user = await 
  }

  FutureOr<void> _SignUpButtonEvent(SignUpButtonEvent event, Emitter<AuthState> emit) {
  }
}
