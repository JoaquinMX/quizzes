import 'package:json_annotation/json_annotation.dart';
import 'package:quizzes/models/question_model.dart';

part 'quiz_model.g.dart';

@JsonSerializable()
class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz(
      {this.id = "",
      this.title = "",
      this.description = "",
      this.video = "",
      this.topic = "",
      this.questions = const []});

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
