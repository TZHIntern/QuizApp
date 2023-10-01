part of 'quiz_data_bloc.dart';

abstract class QuizDataEvent extends Equatable {}

class DataRequestEvent extends QuizDataEvent {
  @override
  List<Object?> get props => [];
}
