import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/auth/signin_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 350),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ));
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black38,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Image.network(
                "https://img.freepik.com/premium-vector/quiz-liquid-bubble-style-quiz-brainy-game-word-vector-illustration_189959-1098.jpg?w=2000",
                width: 100,
                height: 100,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Enter the registerd email and send the reset password link to the email!.",
                style: TextStyle(fontSize: 14, color: Color(0xFF5390d9)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: "Email",
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.black38))),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return value != null && !EmailValidator.validate(value)
                      ? 'Enter a valid email'
                      : null;
                },
              ),
            ),
            const SizedBox(
              height: 30,
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
                    passwordReset();
                  },
                  child: const Text("Reset Password")),
            ),
          ],
        ),
      ),
    );
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "Password resent link is sent to your email",
              style: TextStyle(fontSize: 12),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              e.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          );
        },
      );
    }
  }
}
