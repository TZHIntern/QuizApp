part of 'quiz_data_bloc.dart';

abstract class QuizDataState extends Equatable {}

class QuizDataInitial extends QuizDataState {
  @override
  List<Object?> get props => [];
}

class Loading extends QuizDataState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends QuizDataState {
  final dynamic data;

  SuccessState({required this.data});
  @override
  List<Object?> get props => [data];
}

class ErrorState extends QuizDataState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
