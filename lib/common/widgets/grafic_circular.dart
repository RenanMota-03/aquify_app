import 'dart:developer';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../features/goals/goal_controller.dart';
import '../../locator.dart';
import '../constants/app_colors.dart';
import '../models/goals_model.dart';
import 'package:intl/intl.dart';

class GraficCircularWidget extends StatefulWidget {
  const GraficCircularWidget({super.key});

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
  double intervalos = 0;
  List<String> horario = [];

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

  void _loadHours() {
    String? horaInicio = _goal!.dateBegin;
    String? horaFim = _goal!.dateEnd;
    double intervaloMinutos = 0; // Defina o tamanho do intervalo
    double quantidadeMl = _parseDouble(_goal!.quantidadeMl!);
    quantidadeMl = quantidadeMl / 1000;
    double meta = _parseDouble(_goal?.metaL);

    DateFormat format = DateFormat("HH:mm");

    DateTime inicio = format.parse(horaInicio!);
    DateTime fim = format.parse(horaFim!);

    // Calculando a diferença total
    Duration diferenca = fim.difference(inicio);
    int totalMinutos = diferenca.inMinutes;
    double numIntervalos = meta / quantidadeMl;
    intervaloMinutos = totalMinutos / numIntervalos;

    List<String> horarios = [];
    for (int i = 0; i <= numIntervalos; i++) {
      DateTime horarioAtual = inicio.add(
        Duration(minutes: i * intervaloMinutos.toInt()),
      );
      horarios.add(format.format(horarioAtual));
    }

    intervalos = numIntervalos;
    horario = horarios;
    log("Total de intervalos: $numIntervalos");
    log("Horários dos intervalos: $horarios");
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
            centerSpaceRadius: 110,
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
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.blueOne,
            value: 70,
            title: '70%',
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
            value: 30,
            title: '30%',
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
    if (_goal != null) {
      _loadHours();
      log("$horario");
      log("$intervalos");
    }
    if (index < 0) {
      graficoLabel = 'Meta';
      graficoValor = _parseDouble(_goal?.metaL);
    } else if (index == 1) {
      graficoLabel = 'Restante';
      graficoValor = 30;
    } else {
      graficoLabel = "Bebido";
      graficoValor = 70;
    }
  }
}
