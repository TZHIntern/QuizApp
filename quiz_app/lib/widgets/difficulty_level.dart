import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/difficulty/difficulty_level_bloc.dart';

class DifficultyLevelWidget extends StatelessWidget {
  DifficultyLevelWidget({
    Key? key,
    required this.selectedIndex,
    required this.difficulty,
  }) : super(key: key);

  final int selectedIndex;
  final int difficulty;

  final List<String> level = ['Easy', 'Medium', 'Hard'];
  final List<String> levelLowercase = ['easy', 'medium', 'hard'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<DifficultyLevelBloc>(context).add(DifficultySelectEvent(
          categoryIndex: selectedIndex,
          difficultyLevel: levelLowercase[difficulty],
        ));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF48bfe3), Color(0xFF6930c3)]),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Text(
          level[difficulty],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
