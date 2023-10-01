import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:quiz_app/data/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(UnAuthenciatedState()) {
    on<ProfileImageChangeEvent>(profileImageChangeEvent);
    on<SignInEvent>(signInEvent);
    on<SignUpEvent>(signUpEvent);
    on<GoogleSignUpEvent>(googleSignUpEvent);
    on<SignOutEvent>(signOutEvent);
  }

  FutureOr<void> profileImageChangeEvent(
      ProfileImageChangeEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) {
    emit(LoadingState());
    try {
      authRepository.signIn(email: event.email, password: event.password);
      emit(AuthenciatedState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
      emit(UnAuthenciatedState());
    }
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) {
    emit(LoadingState());
    try {
      authRepository.signUp(
          email: event.email, password: event.password, name: event.userName);
      FirebaseFirestore.instance.collection('user').add({
        'email': event.email,
        'name': event.userName,
        'profileImg': '',
        'time': DateTime.now().toString()
      });
      emit(NavigateToLoginState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
      emit(UnAuthenciatedState());
    }
  }

  FutureOr<void> googleSignUpEvent(
      GoogleSignUpEvent event, Emitter<AuthState> emit) {
    emit(LoadingState());
    try {
      authRepository.signInWithGoogle();
      emit(AuthenciatedState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
      emit(UnAuthenciatedState());
    }
  }

  FutureOr<void> signOutEvent(SignOutEvent event, Emitter<AuthState> emit) {
    emit(LoadingState());
    authRepository.signOut();
    emit(UnAuthenciatedState());
  }
}
