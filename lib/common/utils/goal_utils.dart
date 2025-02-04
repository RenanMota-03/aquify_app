import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

DateTime _parseNextHour(String nextHour) {
  final now = DateTime.now();
  final parts = nextHour.split(":");
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  return DateTime(now.year, now.month, now.day, hour, minute);
}

bool withinMarginDelay(String nextHour) {
  final nextHourDateTime = _parseNextHour(nextHour);
  final now = DateTime.now();
  return now.isBefore(nextHourDateTime.add(const Duration(minutes: 5)));
}

bool timeHasPassed(String nextHour) {
  final nextHourDateTime = _parseNextHour(nextHour);
  return DateTime.now().isAfter(
    nextHourDateTime.add(const Duration(minutes: 5)),
  );
}

Color defineTimeColor({
  required String nextHour,
  required Set<String> consumedTimes,
}) {
  if (consumedTimes.contains(nextHour)) {
    return Colors.green;
  } else if (timeHasPassed(nextHour)) {
    return AppColors.error;
  }
  return AppColors.blueOne;
}
