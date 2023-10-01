import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/utility/prepare_quiz.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  PrepareQuizs quizHelper;
  int currentIndex = 0;
  int currentAttempt = 0;
  int currentCorrectAttempt = 0;
  int currentWrongAttempt = 0;
  QuizBloc(this.quizHelper)
      : super(QuizOnGoingState(quizHelper.getQuestion(0), quizHelper.options(0),
            currentScore: 0,
            currentIndex: 0,
            currentAttempt: 0,
            currentWrongAttempts: 0,
            currentCorrectAttempts: 0)) {
    double getScore() {
      return (currentCorrectAttempt * 1) - (currentWrongAttempt * 0.25);
    }

    on<NextQuestionEvent>((event, emit) {
      if (event.selectedIndex != -1 &&
          quizHelper.isCorrect(currentIndex, event.selectedIndex)) {
        ++currentCorrectAttempt;
      }
      currentAttempt = currentIndex + 1;
      currentWrongAttempt = currentAttempt - currentCorrectAttempt;
      double score = getScore();
      ++currentIndex;
      QuizState nextQuestionState = QuizOnGoingState(
          quizHelper.getQuestion(currentIndex),
          quizHelper.options(currentIndex),
          currentScore: score,
          currentIndex: currentIndex,
          currentAttempt: currentAttempt,
          currentWrongAttempts: currentWrongAttempt,
          currentCorrectAttempts: currentCorrectAttempt);
      emit(nextQuestionState);
    });
    on<QuizFinishedEvent>((event, emit) {
      if (event.selectedIndex != -1 &&
          quizHelper.isCorrect(currentIndex, event.selectedIndex)) {
        ++currentCorrectAttempt;
      }
      currentAttempt = currentIndex + 1;
      currentWrongAttempt = currentAttempt - currentCorrectAttempt;
      double formulaScore = getScore();
      ++currentIndex;
      QuizState finishedState = FinishedQuizState(
          currentScore: formulaScore,
          currentIndex: currentIndex,
          currentAttempt: currentAttempt,
          currentWrongAttempts: currentWrongAttempt,
          currentCorrectAttempts: currentCorrectAttempt);
      emit(finishedState);
    });
  }
}
