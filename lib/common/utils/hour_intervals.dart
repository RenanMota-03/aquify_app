import 'package:intl/intl.dart';

class HourIntervals {
  HourIntervals._();
  int intervalos = 0;
  List<DateTime> horario = [];
  List<DateTime> horarios = [];
  DateTime now = DateTime.now();
  DateTime? nextHour;
  DateFormat format = DateFormat("HH:mm");
  double _parseDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  void loadHours({
    required dateBegin,
    required dateEnd,
    required quantidade,
    required metaL,
  }) {
    String? horaInicio = dateBegin;
    String? horaFim = dateEnd;
    if (horaInicio == null || horaFim == null) return;

    double quantidadeMl = _parseDouble(quantidade) / 1000;
    double meta = _parseDouble(metaL);

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
    _updateNextHour();
  }

  void _updateNextHour() {
    now = DateTime.now();
    nextHour = null;

    for (DateTime horario in horarios) {
      if (horario.isAfter(now)) {
        nextHour = _roundToNextTenMinutes(horario);
        break;
      }
    }
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
}
