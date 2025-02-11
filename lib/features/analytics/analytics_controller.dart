import 'package:flutter/material.dart';
import '../../services/firebase_firestore_service.dart';
import '../../common/models/analytics_model.dart';
import 'analytics_state.dart';

class AnalyticsController extends ChangeNotifier {
  final FirebaseFirestoreService _service;

  AnalyticsController(this._service);

  AnalyticsState _state = AnalyticsStateInitial();
  AnalyticsState get state => _state;

  void _changeState(AnalyticsState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchAnalyticsData() async {
    _changeState(AnalyticsStateLoading());
    try {
      final List<AnalyticsModel> data = await _service.getAllProgressDays();
      _changeState(AnalyticsStateSuccess(data));
    } catch (e) {
      _changeState(AnalyticsStateError(e.toString()));
    }
  }
}
