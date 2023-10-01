part of 'score_result_bloc.dart';

@immutable
abstract class ScoreResultState extends Equatable {}

class ScoreResultInitial extends ScoreResultState {
  @override
  List<Object?> get props => [];
}

class Loading extends ScoreResultState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends ScoreResultState {
  final dynamic data;
  // final List<flspot> analysisData;
  final String category;
  final String error;

  SuccessState(
      {required this.data,
      // required this.analysisData,
      required this.category,
      required this.error});

  @override
  List<Object?> get props => [];
}
