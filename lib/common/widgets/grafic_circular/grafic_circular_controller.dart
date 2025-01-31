import 'dart:developer';
import 'package:intl/intl.dart';
import '../../../features/goals/goal_controller.dart';
import '../../../locator.dart';
import '../../models/goals_model.dart';

class GraficCircularController {
  final GoalController _goalController = locator.get<GoalController>();
  GoalsModel? goal;
  double graficoValor = 0.0;
  double progressgoal = 0.0;
  double restantgoal = 0.0;
  String graficoLabel = 'Meta';
  int intervalos = 0;
  List<DateTime> horario = [];
  List<DateTime> horarios = [];
  DateTime now = DateTime.now();
  DateTime? nextHour;
  DateFormat format = DateFormat("HH:mm");

  Future<void> loadGoalData() async {
    goal = await _goalController.getGoal();
    graficoValor = _parseDouble(goal?.metaL);
  }

  double _parseDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  void loadHours() {
    if (goal == null) return;

    String? horaInicio = goal!.dateBegin;
    String? horaFim = goal!.dateEnd;
    if (horaInicio == null || horaFim == null) return;

    double quantidadeMl = _parseDouble(goal!.quantidadeMl!) / 1000;
    double meta = _parseDouble(goal!.metaL);

    DateTime now = DateTime.now();
    DateTime inicio = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(horaInicio.split(":")[0]),
      int.parse(horaInicio.split(":")[1]),
    );

    DateTime fim = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(horaFim.split(":")[0]),
      int.parse(horaFim.split(":")[1]),
    );

    if (fim.isBefore(inicio)) {
      fim = fim.add(const Duration(days: 1));
    }

    Duration diferenca = fim.difference(inicio);
    int totalMinutos = diferenca.inMinutes;
    int numIntervalos = (meta / quantidadeMl).floor();
    int intervaloMinutos = totalMinutos ~/ numIntervalos;

    horarios.clear();
    for (int i = 0; i <= numIntervalos; i++) {
      DateTime horarioAtual = inicio.add(
        Duration(minutes: i * intervaloMinutos),
      );
      horarios.add(horarioAtual);
    }
    horario = horarios;
    intervalos = numIntervalos;
    updateNextHour();
  }

  void updateNextHour() {
    now = DateTime.now();
    nextHour = null;

    for (DateTime horario in horarios) {
      if (horario.isAfter(now)) {
        nextHour = _roundToNextTenMinutes(horario);
        break;
      }
    }

    log(
      nextHour != null
          ? "Próximo horário arredondado: ${format.format(nextHour!)}"
          : "Todos os intervalos já passaram.",
    );
  }

  DateTime _roundToNextTenMinutes(DateTime dateTime) {
    int minute = dateTime.minute;
    int roundedMinute = ((minute ~/ 10) + 1) * 10;

    if (roundedMinute == 60) {
      return DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour + 1,
        0,
      );
    }

    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      roundedMinute,
    );
  }

  void dispose() {
    _goalController.dispose();
  }
}
