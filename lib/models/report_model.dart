import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({
    this.uid = "",
    this.total = 0,
    this.topics = const {},
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
