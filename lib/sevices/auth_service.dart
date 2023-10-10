import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final Stream userStream = FirebaseAuth.instance.authStateChanges();
  final FirebaseAuth user = FirebaseAuth.instance;

  Future<void> anonymouslyLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
