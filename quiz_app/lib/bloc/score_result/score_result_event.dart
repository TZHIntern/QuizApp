part of 'score_result_bloc.dart';

@immutable
abstract class ScoreResultEvent extends Equatable {}

class CategoryDataRequested extends ScoreResultEvent {
  final String category;
  final String difficultyLevel;

  CategoryDataRequested(
      {required this.category, required this.difficultyLevel});
  @override
  List<Object?> get props => [category, difficultyLevel];
}
