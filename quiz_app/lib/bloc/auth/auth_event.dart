part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileImageChangeEvent extends AuthEvent {
  final String imageUrl;

  ProfileImageChangeEvent({required this.imageUrl});
  @override
  List<Object> get props => [imageUrl];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  SignUpEvent(
      {required this.userName, required this.email, required this.password});
  @override
  List<Object> get props => [userName, email, password];
}

class GoogleSignUpEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
