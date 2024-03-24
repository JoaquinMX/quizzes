import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizzes/components/animated_progress_bar.dart';
import 'package:quizzes/components/loading_screen.dart';
import 'package:quizzes/models/option_model.dart';
import 'package:quizzes/models/question_model.dart';
import 'package:quizzes/models/quiz_model.dart';
import 'package:quizzes/sevices/firestore_service.dart';
import 'package:quizzes/views/quiz/quiz_state.dart';

class QuizPage extends StatelessWidget {
  final String quizId;
  const QuizPage({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const LoadingScreen();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          var quiz = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: AnimatedProgressBar(value: state.progress),
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(FontAwesomeIcons.xmark)),
            ),
            body: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int index) =>
                    state.progress = index / (quiz.questions.length + 1),
                itemBuilder: (BuildContext context, int index) {
                  print(index);
                  if (index == 0) {
                    return StartPage(quiz: quiz);
                  } else if (index == quiz.questions.length + 1) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[index - 1]);
                  }
                }),
          );
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headlineLarge),
          const Divider(),
          Expanded(
            child: Text(
              quiz.description,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => state.nextPage(),
                icon: Icon(Icons.poll),
                label: const Text("Start quiz!"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Congratulations! You completed the ${quiz.title} quiz",
            textAlign: TextAlign.center,
          ),
          Divider(),
          Image.asset('assets/congrats.gif'),
          const Divider(),
          ElevatedButton.icon(
              onPressed: () {
                FirestoreService().updateUserReport(quiz);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/topics', (route) => false);
              },
              icon: Icon(FontAwesomeIcons.check),
              label: Text(
                "Mark complete!",
              ))
        ]));
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;

  const QuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((Option option) {
              return Container(
                height: 90,
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = option;
                    _bottomSheet(context, option, state);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          state.selected == option
                              ? FontAwesomeIcons.circleCheck
                              : FontAwesomeIcons.circle,
                        ),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text(
                                  option.value,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ))),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  _bottomSheet(BuildContext context, Option option, QuizState state) {
    bool correct = option.correct;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(correct ? "Good job!" : "Try again!"),
                Text(
                  option.detail,
                  style: TextStyle(fontSize: 18, color: Colors.white54),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: correct ? Colors.green : Colors.red,
                    ),
                    onPressed: () {
                      if (correct) {
                        state.nextPage();
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      correct ? "Onward!" : "Try again",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
