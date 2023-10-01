part of 'quiz_bloc.dart';

@immutable
abstract class QuizState extends Equatable {
  final double currentScore;
  final int currentIndex;
  final int currentAttempt;
  final int currentWrongAttempts;
  final int currentCorrectAttempts;

  QuizState(
      {required this.currentScore,
      required this.currentIndex,
      required this.currentAttempt,
      required this.currentWrongAttempts,
      required this.currentCorrectAttempts});
}

class QuizInitial extends QuizState {
  QuizInitial(
      {required super.currentScore,
      required super.currentIndex,
      required super.currentAttempt,
      required super.currentWrongAttempts,
      required super.currentCorrectAttempts});

  @override
  List<Object?> get props => [];
}

class QuizOnGoingState extends QuizState {
  final dynamic currentQuestion;
  final dynamic options;
  QuizOnGoingState(this.currentQuestion, this.options,
      {required super.currentScore,
      required super.currentIndex,
      required super.currentAttempt,
      required super.currentWrongAttempts,
      required super.currentCorrectAttempts});

  @override
  List<Object?> get props => [currentQuestion, options];
}

class FinishedQuizState extends QuizState {
  FinishedQuizState(
      {required super.currentScore,
      required super.currentIndex,
      required super.currentAttempt,
      required super.currentWrongAttempts,
      required super.currentCorrectAttempts});

  @override
  List<Object?> get props => [];
}
