import 'package:flutter/material.dart';
import '../../common/models/analytics_model.dart';
import '../../services/progress_day_service.dart';
import 'analytics_state.dart';

class AnalyticsController extends ChangeNotifier {
  final ProgressDayService _service;

  AnalyticsController(this._service);

  AnalyticsState _state = AnalyticsStateInitial();
  AnalyticsState get state => _state;

  void _changeState(AnalyticsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<List<AnalyticsModel>> fetchAnalyticsData() async {
    _changeState(AnalyticsStateLoading());
    try {
      final List<AnalyticsModel> data = await _service.getAllProgressDays();
      _changeState(AnalyticsStateSuccess());
      return data;
    } catch (e) {
      _changeState(AnalyticsStateError(e.toString()));
      throw Exception();
    }
  }

  Future<void> saveAnalyticsData(
    String day,
    String meta,
    double progress,
  ) async {
    try {
      await _service.saveProgress(day: day, meta: meta, progress: progress);
      fetchAnalyticsData(); // Atualiza a lista após salvar
    } catch (e) {
      _changeState(AnalyticsStateError(e.toString()));
    }
  }
}
