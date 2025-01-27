import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // Ajuste o caminho para o seu projeto

class GraficCircularWidget extends StatefulWidget {
  final ValueChanged<int> onSectionTouched;

  const GraficCircularWidget({super.key, required this.onSectionTouched});

  @override
  State<GraficCircularWidget> createState() => _GraficCircularWidgetState();
}

class _GraficCircularWidgetState extends State<GraficCircularWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceColor: AppColors.blueTwo,
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
                // Reset when the user releases or taps outside a section
                touchedIndex = -1;
                widget.onSectionTouched(touchedIndex); // Notify parent
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
              widget.onSectionTouched(touchedIndex); // Notify parent
            });
          },
        ),
      ),
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
            value: 40,
            title: '40%',
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
}
