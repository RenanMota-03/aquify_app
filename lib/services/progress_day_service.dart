import 'package:aquify_app/common/models/analytics_model.dart';

abstract class ProgressDayService {
  Future<void> saveProgress({
    required String day,
    required String meta,
    required double progress,
  });
  Future<List<AnalyticsModel>> getAllProgressDays();
}
