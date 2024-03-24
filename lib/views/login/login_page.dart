import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzes/sevices/auth_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlutterLogo(size: 150),
              Flexible(
                  child: LoginButton(
                icon: FontAwesomeIcons.google,
                text: 'Sign in with Google',
                loginMethod: AuthService().googleLogin,
                color: Colors.blue,
              )),
              FutureBuilder(
                  future: SignInWithApple.isAvailable(),
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return SignInWithAppleButton(onPressed: () {
                        //AuthService().appleLogin();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                                "This feature is not available in demo projects.",
                                style: TextStyle(color: Colors.white)),
                          ),
                        );
                      });
                    } else {
                      return Container();
                    }
                  }),
              Flexible(
                  child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as a Guest',
                loginMethod: AuthService().anonymouslyLogin,
                color: Colors.deepPurple,
              )),
            ]),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function() loginMethod;
  LoginButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.text,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        label: Text(text),
        onPressed: () => loginMethod(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(24),
          backgroundColor: color,
        ),
      ),
    );
  }
}
