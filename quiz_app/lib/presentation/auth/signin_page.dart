import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiz_app/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/presentation/auth/forget_password.dart';
import 'package:quiz_app/presentation/auth/signUp_page.dart';
import 'package:quiz_app/presentation/dashboard/dashboard_page.dart';
import 'package:email_validator/email_validator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenciatedState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashBoardPage(),
                ));
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenciatedState || state is NavigateToLoginState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://img.freepik.com/premium-vector/quiz-liquid-bubble-style-quiz-brainy-game-word-vector-illustration_189959-1098.jpg?w=2000",
                          width: 100,
                          height: 100,
                        ),
                        const Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Form(
                            key: key,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: "Email",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black38))),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null &&
                                            !EmailValidator.validate(value)
                                        ? 'Enter a valid email'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black38))),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null && value.length < 6
                                        ? "Enter min. 6 characters"
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 250),
                                  child: InkWell(
                                    child: const Text(
                                      "Forget Password?",
                                      style:
                                          TextStyle(color: Color(0xFF5390d9)),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgetPasswordPage(),
                                          ));
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
                                      gradient: LinearGradient(colors: [
                                    Color(0xFF48bfe3),
                                    Color(0xFF6930c3)
                                  ])),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent),
                                      onPressed: () {
                                        authenticatedWithEmail(context);
                                      },
                                      child: const Text("Login")),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "or",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF03045e)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                authenciatedWithGoogle(context);
                              },
                              icon: Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                                height: 30,
                                width: 25,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: InkWell(
                            child: const Text(
                                "Don't have an account? SignUp Here"),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                          ),
                        )
                      ],
                    ),
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

  void authenticatedWithEmail(BuildContext context) {
    if (key.currentState!.validate()) {
      context.read<AuthBloc>().add(SignInEvent(
          email: emailController.text, password: passwordController.text));
    }
  }

  void authenciatedWithGoogle(BuildContext context) {
    context.read<AuthBloc>().add(GoogleSignUpEvent());
  }
}
