import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/presentation/main/result_detail.dart';

import 'package:quiz_app/utility/prepare_quiz.dart';
import 'package:quiz_app/widgets/option_widget.dart';

import '../../bloc/quiz/quiz_bloc.dart';

class QuestionPaper extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final questionData;
  final int categoryIndex;
  final String difficultyLevel;
  const QuestionPaper(
      {super.key,
      this.questionData,
      required this.categoryIndex,
      required this.difficultyLevel});

  @override
  State<QuestionPaper> createState() => _QuestionPaperState();
}

class _QuestionPaperState extends State<QuestionPaper> {
  PrepareQuizs questionPaper = PrepareQuizs();
  int questionNumber = 0;
  bool isAbsorbing = false;
  final int duration = 10;
  List<Color> optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  int selectedOption = 0;

  @override
  void initState() {
    questionPaper.populateList(widget.questionData);
    super.initState();
  }

  List<Widget> buildOptions(List<String> option) {
    List<Widget> options = [];

    for (var i = 0; i < 4; i++) {
      options.add(OptionsWidget(
        widget: widget,
        option: option[i].toString(),
        onTap: () {
          setState(() {
            // if (selectedOption != -1) {
            //   optionsColor[selectedOption] = Colors.white;
            // }
            selectedOption = i;
            optionsColor[selectedOption] = Colors.black;
          });
        },
        optionColor: optionsColor[i],
      ));
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(questionPaper),
      child: BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is FinishedQuizState) {
            navigateToResultScreen(context, state);
          }
        },
        child: BlocBuilder<QuizBloc, QuizState>(
          buildWhen: (previous, current) => true,
          builder: (context, state) {
            if (state is QuizOnGoingState) {
              return AbsorbPointer(
                absorbing: isAbsorbing,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 10),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("${state.currentIndex + 1} of 10")),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("${state.currentQuestion}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ...buildOptions(state.options),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    navigateToResultScreen(context, state);
                                  },
                                  child: const Text(
                                    "Finish",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    if (state.currentIndex < 9) {
                                      if (selectedOption != 1) {
                                        optionsColor[selectedOption] =
                                            Colors.white;
                                      }
                                      int selectedIndex = selectedOption;
                                      selectedOption = -1;
                                      BlocProvider.of<QuizBloc>(context).add(
                                          NextQuestionEvent(
                                              selectedIndex: selectedIndex));
                                    } else {
                                      BlocProvider.of<QuizBloc>(context).add(
                                          QuizFinishedEvent(
                                              selectedIndex: selectedOption));
                                    }
                                  },
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void navigateToResultScreen(BuildContext context, QuizState state) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
              score: state.currentScore,
              diffcultyLevel: widget.difficultyLevel,
              categoryIndex: widget.categoryIndex,
              attempts: state.currentAttempt,
              wrongAttempts: state.currentWrongAttempts,
              correctAttempts: state.currentCorrectAttempts,
              isSaved: false),
        ));
  }
}
