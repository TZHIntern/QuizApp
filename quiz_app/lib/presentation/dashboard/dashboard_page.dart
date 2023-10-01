import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/presentation/auth/signin_page.dart';
import 'package:quiz_app/presentation/dashboard/category/category_screen.dart';
import 'package:quiz_app/widgets/drawer_widget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black45),
            backgroundColor: Colors.white,
            title: const Text(
              'Quizard',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.home,
                  color: Color(0xFF4895ef),
                )),
                Tab(icon: Icon(Icons.score, color: Color(0xFF4895ef))),
              ],
            ),
          ),
          drawer: DrawerWidget(user: user),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenciatedState) {
                // Navigate to the sign in screen when the user Signs Out
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                  (route) => false,
                );
              }
            },
            child: const TabBarView(
              children: [CategoryScreen(), Text("Score")],
            ),
          ),
        ));
  }
}
