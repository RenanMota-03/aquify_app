import 'package:intl/intl.dart';

import '../models/analytics_model.dart';

void organizeDataByMonth(
  List<AnalyticsModel> data,
  Map<String, List<AnalyticsModel>> monthlyData,
) {
  monthlyData.clear();

  for (var item in data) {
    DateTime date = DateTime.parse(item.day);
    String monthKey = DateFormat('MMMM/yyyy', 'pt_BR').format(date);

    if (!monthlyData.containsKey(monthKey)) {
      monthlyData[monthKey] = [];
    }
    monthlyData[monthKey]!.add(item);
  }
}
