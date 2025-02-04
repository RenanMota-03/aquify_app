import 'dart:developer';

import 'package:aquify_app/common/models/updategoal_model.dart';
import 'package:aquify_app/services/goals_service.dart';
import 'package:flutter/foundation.dart';
import '../../common/models/goals_model.dart';
import '../../services/secure_storage.dart';
import 'goal_state.dart';

class GoalController extends ChangeNotifier {
  final SecureStorage _service;
  final GoalsService _serviceGoal;
  GoalController(this._service, this._serviceGoal);
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
      return GoalsModel.fromJson(result);
    }
    return null;
  }

  void isDay({String? now, required double progressgoal}) async {
    try {
      final day = await _serviceGoal.isDayUpdate(now, progressgoal);
      log(day.toJson());
      log('as${day.progressgoal.toString()}');
      _service.write(key: "Day", value: day.toJson());
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<UpdateGoalModel?> getDay() async {
    final result = await _service.readOne(key: "Day");
    if (result != null) {
      return UpdateGoalModel.fromJson(result);
    }
    return null;
  }
}
