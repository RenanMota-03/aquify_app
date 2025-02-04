import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/models/updategoal_model.dart';
import 'package:aquify_app/common/utils/grafic_circular_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../features/goals/goal_controller.dart';
import '../../locator.dart';
import '../constants/app_colors.dart';
import '../models/goals_model.dart';
import '../utils/parse_double_utils.dart';

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
  double? progressSave;
  double progressgoal = 0.0;
  double restantgoal = 0.0;
  String graficoLabel = 'Meta';
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    _loadGoalData();
    resetGoal();
  }

  void _loadGoalData() async {
    GoalsModel? goal = await _goalController.getGoal();
    setState(() {
      _goal = goal;
      graficoValor = parseDouble(goal?.metaL);
      progressgoal = progressSave ?? 0.0;
    });
  }

  void resetGoal() async {
    UpdateGoalModel? day = await _goalController.getDay();
    DateTime date = DateTime.parse(day!.now!);
    setState(() {
      if (date.day < now.day && date.month == now.month) {
        _goalController.isDay(now: now.toString(), progressgoal: 0.0);
        progressgoal = 0.0;
      } else if (date.month != now.month) {
        _goalController.isDay(now: now.toString(), progressgoal: 0.0);
        progressgoal = 0.0;
      } else {
        progressgoal = day.progressgoal;
      }
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final graficoDados = setGraficoDados(
      touchedIndex: touchedIndex,
      meta: _goal?.metaL,
      progress: widget.progress,
      progressgoal: progressgoal,
      restantgoal: restantgoal,
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 120,
            sections: showingSections(
              meta: _goal?.metaL,
              progress: widget.progress,
              progressgoal: progressgoal,
              restantgoal: restantgoal,
              touchedIndex: touchedIndex,
            ),
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (event is FlTapUpEvent ||
                      !event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    graficoDados;
                    graficoLabel = graficoDados["graficoLabel"];
                    graficoValor = graficoDados["graficoValor"];
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                  graficoDados;
                  graficoLabel = graficoDados["graficoLabel"];
                  graficoValor = graficoDados["graficoValor"];
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
}
