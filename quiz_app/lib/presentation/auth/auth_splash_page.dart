import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/auth/signUp_page.dart';
import 'package:quiz_app/presentation/auth/signin_page.dart';

class AuthSplashPage extends StatelessWidget {
  const AuthSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                "Quizard",
                style: TextStyle(
                    color: Color(0xFF03045e),
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "100+ quizs to challenge you and your friend",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFa3c4f3),
              ),
            ),
            Center(
              child: Image.network(
                "https://img.freepik.com/premium-vector/quiz-liquid-bubble-style-quiz-brainy-game-word-vector-illustration_189959-1098.jpg?w=2000",
                width: 300,
                height: 500,
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF48bfe3), Color(0xFF6930c3)])),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                  child: const Text("Login")),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xFF03045e)),
                      bottom: BorderSide(color: Color(0xFF0096c7)),
                      left: BorderSide(color: Color(0xFF0077b6)),
                      right: BorderSide(color: Color(0xFF03045e)))),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
