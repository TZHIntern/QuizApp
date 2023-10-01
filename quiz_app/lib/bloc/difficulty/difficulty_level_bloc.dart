import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/utility/category_list.dart';

part 'difficulty_level_event.dart';
part 'difficulty_level_state.dart';

class DifficultyLevelBloc
    extends Bloc<DifficultyLevelEvent, DifficultyLevelState> {
  DifficultyLevelBloc() : super(DifficultyLevelInitial()) {
    on<InitDiffultyEvent>(initDiffultyEvent);
    on<DifficultySelectEvent>(difficultySelectEvent);
  }

  FutureOr<void> initDiffultyEvent(
      InitDiffultyEvent event, Emitter<DifficultyLevelState> emit) {
    emit(LoadedState(
        title: categoryDetailList[event.categoryIndex].title,
        color: categoryDetailList[event.categoryIndex].textColor));
  }

  FutureOr<void> difficultySelectEvent(
      DifficultySelectEvent event, Emitter<DifficultyLevelState> emit) {
    emit(StartQuizState(
        categoryIndex: event.categoryIndex,
        difficultyLevel: event.difficultyLevel));
  }
}
