import 'package:aquify_app/common/models/goals_model.dart';
import 'package:aquify_app/services/goals_service.dart';

class NewGoalsServiceImpl implements GoalsService {
  @override
  Future<GoalsModel> createGoal({
    required String? id,
    required String? meta,
    required String? dateBegin,
    required String? dateEnd,
    required String? quantidadeMl,
  }) async {
    return GoalsModel(
      id: id,
      dateBegin: dateBegin,
      dateEnd: dateEnd,
      metaL: meta,
      quantidadeMl: quantidadeMl,
    );
  }
}
