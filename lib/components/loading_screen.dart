import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 250,
        height: 250,
        child: Center(child: CircularProgressIndicator()));
  }
}
