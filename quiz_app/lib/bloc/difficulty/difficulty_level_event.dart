part of 'difficulty_level_bloc.dart';

@immutable
abstract class DifficultyLevelEvent extends Equatable {}

class InitDiffultyEvent extends DifficultyLevelEvent {
  final int categoryIndex;

  InitDiffultyEvent({required this.categoryIndex});
  @override
  List<Object?> get props => [categoryIndex];
}

class DifficultySelectEvent extends DifficultyLevelEvent {
  final int categoryIndex;
  final String difficultyLevel;

  DifficultySelectEvent(
      {required this.categoryIndex, required this.difficultyLevel});
  @override
  List<Object?> get props => [categoryIndex, difficultyLevel];
}
