import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/utility/category_list.dart';
import 'package:quiz_app/data/repos/quiz_repo.dart';
import 'package:quiz_app/presentation/main/question_screen.dart';

import '../../bloc/quiz_data/quiz_data_bloc.dart';

class PrepareQuiz extends StatelessWidget {
  final int categoryIndex;
  final String difficultyLevel;
  const PrepareQuiz(
      {super.key, required this.categoryIndex, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => QuizRepo(
          url:
              'https://the-trivia-api.com/api/questions?categories=${categoryDetailList[categoryIndex].category}&limit=10&difficulty=$difficultyLevel'),
      child: BlocProvider(
        create: (context) =>
            QuizDataBloc(RepositoryProvider.of<QuizRepo>(context))
              ..add(DataRequestEvent()),
        child: BlocListener<QuizDataBloc, QuizDataState>(
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPaper(
                        questionData: state.data,
                        categoryIndex: categoryIndex,
                        difficultyLevel: difficultyLevel),
                  ));
            }
            if (state is ErrorState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.error),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"))
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<QuizDataBloc, QuizDataState>(
            builder: (context, state) {
              return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
