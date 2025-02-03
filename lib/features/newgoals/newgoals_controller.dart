import 'package:aquify_app/services/goals_service.dart';
import 'package:flutter/material.dart';

import '../../services/secure_storage.dart';
import 'newgoals_state.dart';

class NewGoalsController extends ChangeNotifier {
  final GoalsService _service;
  NewGoalsController(this._service);

  NewGoalsState _state = NewGoalsStateInitial();

  NewGoalsState get state => _state;

  void _changeState(NewGoalsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> newGoals({
    required String id,
    required String dateBegin,
    required String dateEnd,
    required String meta,
    required String quantidadeMl,
    required List<String> listHour,
  }) async {
    const secureStorage = SecureStorage();
    _changeState(NewGoalsStateLoading());
    try {
      final goal = await _service.createGoal(
        id: id,
        dateBegin: dateBegin,
        dateEnd: dateEnd,
        meta: meta,
        quantidadeMl: quantidadeMl,
        listHour: listHour,
      );
      if (goal.id != null) {
        await secureStorage.write(key: "Goal", value: goal.toJson());
        _changeState(NewGoalsStateSuccess());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(NewGoalsStateError(e.toString()));
    }
  }
}
