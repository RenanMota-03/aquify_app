import 'dart:developer';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // Ajuste o caminho para o seu projeto

class GraficCircularWidget extends StatefulWidget {
  const GraficCircularWidget({super.key});

  @override
  State<GraficCircularWidget> createState() => _GraficCircularWidgetState();
}

class _GraficCircularWidgetState extends State<GraficCircularWidget> {
  int touchedIndex = -1;
  double graficoValor = 100;
  String graficoLabel = 'Meta';
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
                    // Reset when the user releases or taps outside a section
                    touchedIndex = -1;
                    setGraficoDados(touchedIndex); // Notify parent
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                  setGraficoDados(touchedIndex); // Notify parent
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
    if (index < 0) {
      graficoLabel = 'Meta';
      graficoValor = 100;
    } else if (index == 1) {
      graficoLabel = 'Restante';
      graficoValor = 30;
    } else {
      graficoLabel = "Bebido";
      graficoValor = 70;
    }
  }
}
