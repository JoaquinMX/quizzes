import 'package:flutter/material.dart';
import 'package:quizzes/sevices/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ElevatedButton(
          onPressed: () async {
            await AuthService().signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          child: Text('Sign Out')),
    );
  }
}
