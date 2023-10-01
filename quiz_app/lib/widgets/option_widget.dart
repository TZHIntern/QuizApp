import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/main/question_screen.dart';

class OptionsWidget extends StatelessWidget {
  final QuestionPaper widget;
  final String option;
  final VoidCallback onTap;
  final Color? optionColor;

  const OptionsWidget(
      {super.key,
      required this.widget,
      required this.option,
      required this.onTap,
      this.optionColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                  colors: [Color(0xFF48bfe3), Color(0xFF6930c3)])),
          child: Text(
            option,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: optionColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
