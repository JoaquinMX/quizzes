import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            child:
                Text('About', style: Theme.of(context).textTheme.labelLarge)),
      ),
    );
  }
}
