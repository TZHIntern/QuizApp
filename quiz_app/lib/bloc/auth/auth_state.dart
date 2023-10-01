part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UserDataChangeState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthenciatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenciatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class NavigateToLoginState extends AuthState {
  @override
  List<Object?> get props => [];
}
