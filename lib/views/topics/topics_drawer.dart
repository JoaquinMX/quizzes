import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizzes/models/models.dart';

class TopicsDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicsDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.separated(
      itemCount: topics.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Topic topic = topics[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                topic.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            ),
            QuizList(topic: topic)
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map((quiz) {
        return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 4,
            margin: EdgeInsets.all(4),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    quiz.title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    quiz.description,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  leading: QuizBadge(topic: topic, quizId: quiz.id),
                ),
              ),
            ));
      }).toList(),
    );
  }
}

class QuizBadge extends StatelessWidget {
  final Topic topic;
  final String quizId;
  const QuizBadge({super.key, required this.topic, required this.quizId});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return const Icon(
        FontAwesomeIcons.checkDouble,
        color: Colors.green,
      );
    } else {
      return const Icon(
        FontAwesomeIcons.solidCircle,
        color: Colors.grey,
      );
    }

    return const Placeholder();
  }
}
