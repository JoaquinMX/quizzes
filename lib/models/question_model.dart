import 'package:json_annotation/json_annotation.dart';
import 'package:quizzes/models/option_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
class Question {
  String text;
  List<Option> options;
  Question({this.text = "", this.options = const []});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
