import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../common/models/goals_model.dart';
import '../../services/secure_storage.dart';
import 'goal_state.dart';

class GoalController extends ChangeNotifier {
  final SecureStorage _service;
  GoalController(this._service);
  GoalState _state = GoalStateInitial();
  GoalState get state => _state;
  void _changeState(GoalState newState) {
    _state = newState;
    notifyListeners();
  }

  void isGoalCreate() async {
    final result = await _service.readOne(key: "Goal");
    if (result != null) {
      _changeState(GoalStateSuccess());
    } else {
      _changeState(GoalStateError());
    }
  }

  Future<GoalsModel?> getGoal() async {
    final result = await _service.readOne(key: "Goal");
    if (result != null) {
      log(result);
      return GoalsModel.fromJson(result);
    }
    return null;
  }
}
