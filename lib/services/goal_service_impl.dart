import 'package:aquify_app/common/models/goals_model.dart';
import 'package:aquify_app/common/models/updategoal_model.dart';
import 'package:aquify_app/services/goals_service.dart';

class NewGoalsServiceImpl implements GoalsService {
  @override
  Future<GoalsModel> createGoal({
    required String? id,
    required String? meta,
    required String? dateBegin,
    required String? dateEnd,
    required String? quantidadeMl,
    List<String>? listHour,
  }) async {
    return GoalsModel(
      id: id,
      dateBegin: dateBegin,
      dateEnd: dateEnd,
      metaL: meta,
      quantidadeMl: quantidadeMl,
      listHour: listHour,
    );
  }

  @override
  Future<UpdateGoalModel> isDayUpdate(
    String? now,
    double progressgoal,
    Set<String>? selectedTimes,
  ) async {
    return UpdateGoalModel(
      now: now,
      progressgoal: progressgoal,
      selectedTimes: selectedTimes,
    );
  }
}
