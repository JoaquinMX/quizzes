import 'package:quizzes/views/about/about_page.dart';
import 'package:quizzes/views/home/home_page.dart';
import 'package:quizzes/views/login/login_page.dart';
import 'package:quizzes/views/profile/profile_page.dart';
import 'package:quizzes/views/topics/topics_page.dart';

var appRoutes = {
  '/': (context) => const HomePage(),
  '/about': (context) => const AboutPage(),
  '/login': (context) => const LoginPage(),
  '/profile': (context) => const ProfilePage(),
  '/topics': (context) => const TopicsPage(),
};
