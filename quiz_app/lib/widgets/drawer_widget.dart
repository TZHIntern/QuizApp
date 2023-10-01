import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/auth/auth_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: Drawer(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // const SizedBox(
          //   height: 30,
          // ),
          SizedBox(
            height: 200,
            width: 310,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF48bfe3), Color(0xFF6930c3)])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage("${user!.photoURL}"),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: const Color(0xFFEEEDE7)),
                            onPressed: () {},
                            child: const Text(
                              "Edit",
                              style: TextStyle(color: Colors.grey),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${user!.displayName}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${user!.email}",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ),
          const Padding(
              padding: EdgeInsets.only(left: 30), child: Text("BROWSE")),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              GestureDetector(
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.person,
                      ),
                      onPressed: () {},
                    ),
                    title: const Text("My Profile"),
                  ),
                  onTap: () {}),
              GestureDetector(
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.task,
                      ),
                      onPressed: () {},
                    ),
                    title: const Text("About App"),
                  ),
                  onTap: () {}),
              GestureDetector(
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.logout,
                      ),
                      onPressed: () {},
                    ),
                    title: const Text("Log out"),
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                  })
            ],
          )
        ])));
  }
}
