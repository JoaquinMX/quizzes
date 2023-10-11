import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzes/models/report_model.dart';
import 'package:quizzes/sevices/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.photoURL ??
                              "https://www.gravatar.com/avatar/placeholder"),
                        )),
                  ),
                  Text(
                    user.email ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Quizzes Completed',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    report.total.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                  child: Text('logout')),
              Spacer()
            ])),
      );
    } else {
      return Scaffold(
          body: Center(
              child: Text(
        'Please login',
      )));
    }
  }
}
