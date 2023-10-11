import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzes/models/quiz_model.dart';
import 'package:quizzes/models/report_model.dart';
import 'package:quizzes/models/topic_model.dart';
import 'package:quizzes/sevices/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((doc) => doc.data());
    var topics = data.map((e) => Topic.fromJson(e));
    return topics.toList();
  }

  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    var data = snapshot.data();
    return Quiz.fromJson(data ?? {});
  }

  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  Future<void> updateUserReport(Quiz quiz) {
    try {
      var user = AuthService().user!;
      var ref = _db.collection('reports').doc(user.uid);

      var data = {
        'total': FieldValue.increment(1),
        'topics': {
          'quiz.topic': FieldValue.arrayUnion([quiz.id])
        }
      };
      return ref.set(data, SetOptions(merge: true));
    } catch (e) {
      return Future.error(e);
    }
  }
}
