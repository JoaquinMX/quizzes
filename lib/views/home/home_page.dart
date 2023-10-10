import 'package:flutter/material.dart';
import 'package:quizzes/sevices/auth_service.dart';
import 'package:quizzes/views/login/login_page.dart';
import 'package:quizzes/views/topics/topics_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return const TopicsPage();
          } else {
            return const LoginPage();
          }
        });
  }
}
