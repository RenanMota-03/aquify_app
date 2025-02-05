import 'package:aquify_app/common/models/goals_model.dart';
import 'package:aquify_app/common/models/updategoal_model.dart';

abstract class GoalsService {
  Future<GoalsModel> createGoal({
    required String? id,
    required String? meta,
    required String? dateBegin,
    required String? dateEnd,
    required String? quantidadeMl,
    List<String>? listHour,
  });
  Future<UpdateGoalModel> isDayUpdate(
    String? day,
    double progressGoal,
    Set<String>? selectedTimes,
  );
}
