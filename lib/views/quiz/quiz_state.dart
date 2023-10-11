import 'package:flutter/material.dart';
import 'package:quizzes/models/option_model.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  Option? _selected;

  final PageController controller = PageController();

  double get progress => _progress;
  Option? get selected => _selected;

  set selected(Option? value) {
    _selected = value;
    notifyListeners();
  }

  set progress(double value) {
    _progress = value;
    notifyListeners();
  }

  void nextPage() async {
    print(controller.page);
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
