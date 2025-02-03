import 'dart:developer';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../features/goals/goal_controller.dart';
import '../../locator.dart';
import '../constants/app_colors.dart';
import '../models/goals_model.dart';

class GraficCircularWidget extends StatefulWidget {
  final double progress;
  const GraficCircularWidget({super.key, required this.progress});

  @override
  State<GraficCircularWidget> createState() => _GraficCircularWidgetState();
}

class _GraficCircularWidgetState extends State<GraficCircularWidget> {
  final _goalController = locator.get<GoalController>();
  GoalsModel? _goal;
  int touchedIndex = -1;
  double graficoValor = 0.0;
  double progressgoal = 0.0;
  double restantgoal = 0.0;
  String graficoLabel = 'Meta';
  @override
  void initState() {
    super.initState();
    _loadGoalData();
  }

  void _loadGoalData() async {
    GoalsModel? goal = await _goalController.getGoal();
    setState(() {
      _goal = goal;
      graficoValor = _parseDouble(goal?.metaL);
    });
  }

  double _parseDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 120,
            sections: showingSections(),
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (event is FlTapUpEvent ||
                      !event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    setGraficoDados(touchedIndex);
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                  setGraficoDados(touchedIndex);
                });
              },
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              graficoLabel,
              style: AppTextStyles.mediumText30.copyWith(
                color: AppColors.darkGrey,
              ),
            ),
            Text("${graficoValor}L", style: TextStyle(fontSize: 28)),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    double metaDouble = _parseDouble(_goal?.metaL);
    if (widget.progress != 0) {
      progressgoal = widget.progress;
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

  setGraficoDados(index) {
    double metaDouble = _parseDouble(_goal?.metaL);
    if (_goal != null) {}
    if (widget.progress != 0) {
      progressgoal = widget.progress;
    }
    if (progressgoal == 0) {
      restantgoal = metaDouble;
    } else {
      restantgoal = metaDouble - progressgoal;
    }
    if (index < 0) {
      graficoLabel = 'Meta';
      graficoValor = metaDouble;
    } else if (index == 1) {
      graficoLabel = 'Restante';
      graficoValor = double.parse(restantgoal.toStringAsFixed(1));
    } else {
      graficoLabel = "Bebido";
      graficoValor = double.parse(progressgoal.toStringAsFixed(1));
    }
  }
}
