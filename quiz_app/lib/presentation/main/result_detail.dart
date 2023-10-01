import 'package:flutter/material.dart';
import 'package:quiz_app/data/repos/score_repo.dart';
import 'package:quiz_app/presentation/dashboard/dashboard_page.dart';
import 'package:quiz_app/utility/category_list.dart';
import 'package:fl_score_bar/fl_score_bar.dart';

class ResultScreen extends StatelessWidget {
  final double score;
  final String diffcultyLevel;
  final int categoryIndex;
  final int attempts;
  final int wrongAttempts;
  final int correctAttempts;
  final bool isSaved;

  final ScoreRepo scoreRepo = ScoreRepo();
  ResultScreen(
      {Key? key,
      required this.score,
      required this.diffcultyLevel,
      required this.categoryIndex,
      required this.attempts,
      required this.wrongAttempts,
      required this.correctAttempts,
      required this.isSaved})
      : super(key: key) {
    if (isSaved == false) {
      scoreRepo.saveScore(
          score,
          diffcultyLevel,
          attempts,
          wrongAttempts,
          correctAttempts,
          categoryIndex,
          categoryDetailList[categoryIndex].title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Center(
              child: Text(
                " ${categoryDetailList[categoryIndex].title} : ${diffcultyLevel.toString()}",
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            IconScoreBar(
              scoreIcon: Icons.star_rounded,
              iconColor: const Color.fromARGB(255, 243, 229, 106),
              score: score > 0 ? score / 2 : 0,
              maxScore: 5,
              readOnly: true,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Your final score: $score",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "Attempts: ${attempts.toString()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Correct Attempts: ${correctAttempts.toString()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Wrong Attempts: ${wrongAttempts.toString()}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF48bfe3), Color(0xFF6930c3)])),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashBoardPage(),
                          ));
                    },
                    child: const Text("Home")),
              ),
            )
          ],
        ));
  }
}
