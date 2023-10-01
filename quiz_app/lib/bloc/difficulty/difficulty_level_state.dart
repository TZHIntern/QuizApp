part of 'difficulty_level_bloc.dart';

@immutable
abstract class DifficultyLevelState extends Equatable {}

class DifficultyLevelInitial extends DifficultyLevelState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends DifficultyLevelState {
  final String title;
  final Color color;

  LoadedState({required this.title, required this.color});
  @override
  List<Object?> get props => [title, color];
}

class StartQuizState extends DifficultyLevelState {
  final String difficultyLevel;
  final int categoryIndex;

  StartQuizState({required this.difficultyLevel, required this.categoryIndex});
  @override
  List<Object?> get props => [difficultyLevel, categoryIndex];
}

class DifficultyErrorState extends DifficultyLevelState {
  final String error;

  DifficultyErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
