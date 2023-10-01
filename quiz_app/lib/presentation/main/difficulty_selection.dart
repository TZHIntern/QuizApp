import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/difficulty/difficulty_level_bloc.dart';
import 'package:quiz_app/presentation/main/prepare_quiz_section.dart';

import 'package:quiz_app/widgets/difficulty_level.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key, required this.categoryIndex});

  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DifficultyLevelBloc()
          ..add(InitDiffultyEvent(categoryIndex: categoryIndex)),
        child: BlocListener<DifficultyLevelBloc, DifficultyLevelState>(
          listener: (context, state) {
            if (state is StartQuizState) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrepareQuiz(
                          categoryIndex: categoryIndex,
                          difficultyLevel: state.difficultyLevel)));
            }
          },
          child: BlocBuilder<DifficultyLevelBloc, DifficultyLevelState>(
              builder: (context, state) {
            if (state is LoadedState) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 40, bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // RoundCloseButton(),
                        ],
                      ),
                      Image.network(
                        "https://img.freepik.com/premium-vector/quiz-liquid-bubble-style-quiz-brainy-game-word-vector-illustration_189959-1098.jpg?w=2000",
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        state.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const Column(
                        children: [
                          Text(
                            'Select Difficulty',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DifficultyLevelWidget(
                              selectedIndex: categoryIndex, difficulty: 0),
                          const SizedBox(height: 20),
                          DifficultyLevelWidget(
                              selectedIndex: categoryIndex, difficulty: 1),
                          const SizedBox(height: 20),
                          DifficultyLevelWidget(
                              selectedIndex: categoryIndex, difficulty: 2),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
        ));
  }
}
