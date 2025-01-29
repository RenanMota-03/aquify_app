import 'package:aquify_app/common/models/goals_model.dart';

abstract class GoalsService {
  Future<GoalsModel> createGoal({
    required String? id,
    required String? meta,
    required String? dateBegin,
    required String? dateEnd,
    required String? quantidadeMl,
  });
}
