import 'package:json_annotation/json_annotation.dart';

part 'option_model.g.dart';

@JsonSerializable()
class Option {
  String value;
  String detail;
  bool correct;
  Option({this.value = "", this.detail = "", this.correct = false});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
