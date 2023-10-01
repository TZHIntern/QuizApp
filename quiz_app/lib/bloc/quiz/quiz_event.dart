part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent extends Equatable {}

class NextQuestionEvent extends QuizEvent {
  final int selectedIndex;

  NextQuestionEvent({required this.selectedIndex});
  @override
  List<Object?> get props => [];
}

class QuizFinishedEvent extends QuizEvent {
  final int selectedIndex;

  QuizFinishedEvent({required this.selectedIndex});
  @override
  List<Object?> get props => [];
}
