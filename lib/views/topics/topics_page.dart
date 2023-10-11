import 'package:flutter/material.dart';
import 'package:quizzes/components/bottom_nav_bar.dart';
import 'package:quizzes/components/loading_screen.dart';
import 'package:quizzes/sevices/firestore_service.dart';
import 'package:quizzes/views/topics/topic_item.dart';
import 'package:quizzes/views/topics/topics_drawer.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            var topics = snapshot.data!;
            return Scaffold(
              drawer: TopicsDrawer(topics: topics),
              appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: const Text("Topics"),
              ),
              body: GridView.count(
                crossAxisCount: 2,
                primary: false,
                padding: EdgeInsets.all(20),
                crossAxisSpacing: 10,
                children:
                    topics.map((topic) => TopicItem(topic: topic)).toList(),
              ),
              bottomNavigationBar: BottomNavBar(),
            );
          } else {
            return const Text("No topics found");
          }
        });
  }
}
