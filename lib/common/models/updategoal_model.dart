import 'dart:convert';

class UpdateGoalModel {
  final String? now;
  final double progressgoal;

  UpdateGoalModel({required this.now, required this.progressgoal});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'now': now, 'progressgoal': progressgoal};
  }

  factory UpdateGoalModel.fromMap(Map<String, dynamic> map) {
    return UpdateGoalModel(
      now: map['now'] as String?,
      progressgoal: map['progressgoal'] as double,
    );
  }
  String toJson() => json.encode(toMap());

  factory UpdateGoalModel.fromJson(String source) =>
      UpdateGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
