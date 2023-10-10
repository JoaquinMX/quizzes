import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzes/routes.dart';
import 'package:quizzes/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initializeApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                routes: appRoutes,
                title: 'Quizzz',
                theme: appTheme,
                initialRoute: '/topics');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
