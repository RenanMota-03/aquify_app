import 'dart:convert';

class UpdateGoalModel {
  final String? now;
  final double progressgoal;
  final Set<String>? selectedTimes;

  UpdateGoalModel({
    required this.now,
    required this.progressgoal,
    this.selectedTimes,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'now': now,
      'progressgoal': progressgoal,
      'selectedTimes': selectedTimes!.toList(),
    };
  }

  factory UpdateGoalModel.fromMap(Map<String, dynamic> map) {
    return UpdateGoalModel(
      now: map['now'] as String?,
      progressgoal: map['progressgoal'] as double,
      selectedTimes:
          (map['selectedTimes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          {},
    );
  }
  String toJson() => json.encode(toMap());

  factory UpdateGoalModel.fromJson(String source) =>
      UpdateGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
