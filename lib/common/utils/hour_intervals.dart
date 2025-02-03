import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/app_text_styles.dart';

class HourIntervals {
  HourIntervals._();
  static final HourIntervals instance = HourIntervals._();
  int intervalos = 0;
  List<DateTime> horarios = [];
  DateTime now = DateTime.now();
  DateFormat format = DateFormat("HH:mm");
  double _parseDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  List<String> loadHours({
    required String dateBegin,
    required String dateEnd,
    required String quantidade,
    required String metaL,
  }) {
    String horaInicio = dateBegin;
    String horaFim = dateEnd;

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

    List<DateTime> horarios = [];

    for (int i = 0; i <= numIntervalos; i++) {
      DateTime horarioAtual = inicio.add(
        Duration(minutes: i * intervaloMinutos),
      );
      horarios.add(horarioAtual);
    }

    List<DateTime> horariosArredondados = _roundToBeforeTenMinutes(
      horarios,
      dateEnd,
    );

    return horariosArredondados.map((horario) {
      return "${horario.hour.toString().padLeft(2, '0')}:${horario.minute.toString().padLeft(2, '0')}";
    }).toList();
  }

  List<DateTime> _roundToBeforeTenMinutes(
    List<DateTime> dateTimes,
    String dateEnd,
  ) {
    if (dateTimes.isEmpty) return [];
    if (dateTimes.length == 1) return dateTimes;

    DateTime now = DateTime.now();
    List<String> endParts = dateEnd.split(":");
    DateTime dateEndTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
    );

    List<DateTime> result = [
      dateTimes.first,
      ...dateTimes.skip(1).take(dateTimes.length - 2).map((dateTime) {
        return _roundToNearestThirtyMinutes(dateTime);
      }),
    ];

    DateTime lastRounded = _roundToNearestThirtyMinutes(dateTimes.last);

    if (lastRounded.isAfter(dateEndTime)) {
      result.add(dateEndTime);
    } else {
      result.add(lastRounded);
    }

    return result;
  }

  DateTime _roundToNearestThirtyMinutes(DateTime dateTime) {
    int deltaMinute;

    if (dateTime.minute < 15) {
      deltaMinute = -dateTime.minute;
    } else if (dateTime.minute < 45) {
      deltaMinute = 30 - dateTime.minute;
    } else {
      deltaMinute = 60 - dateTime.minute;
    }

    return dateTime.add(Duration(minutes: deltaMinute));
  }

  Text viewNextHour({required meta, required progress, nextHour}) {
    double metaDouble = _parseDouble(meta);
    if (nextHour != null) {
      return Text(
        "Próximo horário: ${format.format(nextHour!)}",
        style: AppTextStyles.smallText,
      );
    } else {
      if (((progress * 100) / metaDouble) == 100) {
        return Text("Meta concluida");
      } else {
        return Text("Todos os periodos de agua passaram");
      }
    }
  }
}
