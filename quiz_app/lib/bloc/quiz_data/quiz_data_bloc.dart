import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quiz_app/data/repos/quiz_repo.dart';
part 'quiz_data_event.dart';
part 'quiz_data_state.dart';

class QuizDataBloc extends Bloc<QuizDataEvent, QuizDataState> {
  final QuizRepo quizRepo;
  QuizDataBloc(this.quizRepo) : super(Loading()) {
    on<DataRequestEvent>(dataRequestEvent);
  }

  FutureOr<void> dataRequestEvent(
      DataRequestEvent event, Emitter<QuizDataState> emit) async {
    emit(Loading());
    var result = await InternetConnectionChecker().connectionStatus;

    try {
      if (result == InternetConnectionStatus.connected) {
        final data = await quizRepo.getData();
        emit(SuccessState(data: data));
      } else {
        emit(ErrorState(error: "Please check your internet connection."));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
