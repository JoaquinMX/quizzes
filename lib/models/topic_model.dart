import 'package:json_annotation/json_annotation.dart';
import 'package:quizzes/models/quiz_model.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class Topic {
  final String id;
  final String title;
  final String description;
  final String imgUrl;
  final List<Quiz> quizzes;

  Topic(
      {this.id = "",
      this.title = "",
      this.description = "",
      this.imgUrl = "default.png",
      this.quizzes = const []});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
