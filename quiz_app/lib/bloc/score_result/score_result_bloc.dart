import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

part 'score_result_event.dart';
part 'score_result_state.dart';

class ScoreResultBloc extends Bloc<ScoreResultEvent, ScoreResultState> {
  ScoreResultBloc() : super(ScoreResultInitial()) {
    on<ScoreResultEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
