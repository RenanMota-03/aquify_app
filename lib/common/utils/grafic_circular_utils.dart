import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'parse_double_utils.dart';

List<PieChartSectionData> showingSections({
  progress,
  meta,
  progressgoal,
  restantgoal,
  touchedIndex,
}) {
  double metaDouble = parseDouble(meta);
  if (progress != 0) {
    progressgoal = progress;
  }
  if (progressgoal == 0.0) {
    restantgoal = metaDouble;
  } else {
    restantgoal = metaDouble - progressgoal;
  }
  return List.generate(2, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: AppColors.blueOne,
          value: progressgoal >= metaDouble ? metaDouble : progressgoal,
          title:
              '${progressgoal >= metaDouble ? 100 : ((progressgoal * 100) / metaDouble).toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.iceWhite,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: AppColors.darkGrey,
          value: progressgoal >= metaDouble ? 0.0 : restantgoal,
          title:
              '${progressgoal >= metaDouble ? 0 : ((restantgoal * 100) / metaDouble).toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.iceWhite,
            shadows: shadows,
          ),
        );
      default:
        log("message");
        throw Error();
    }
  });
}

Map<String, dynamic> setGraficoDados({
  required int touchedIndex,
  required String? meta,
  required double progress,
  required double progressgoal,
  required double restantgoal,
}) {
  double metaDouble = parseDouble(meta);
  if (progress != 0) {
    progressgoal = progress;
  }
  if (progressgoal == 0) {
    restantgoal = metaDouble;
  } else {
    restantgoal = metaDouble - progressgoal;
  }

  String graficoLabel;
  double graficoValor;

  if (touchedIndex < 0) {
    graficoLabel = 'Meta';
    graficoValor = metaDouble;
  } else if (touchedIndex == 1) {
    graficoLabel = 'Restante';
    graficoValor = double.parse(restantgoal.toStringAsFixed(1));
  } else {
    graficoLabel = "Bebido";
    graficoValor = double.parse(progressgoal.toStringAsFixed(1));
  }

  return {"graficoLabel": graficoLabel, "graficoValor": graficoValor};
}
