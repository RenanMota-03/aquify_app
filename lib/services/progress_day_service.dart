import 'package:aquify_app/common/models/analytics_model.dart';

abstract class ProgressDayService {
  Future<void> saveProgressDay(AnalyticsModel analytics);
  Future<List<AnalyticsModel>> getAllProgressDays();
}
