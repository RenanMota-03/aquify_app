import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/analytics_model.dart';

class GraficLineAnalyticsWidget extends StatefulWidget {
  final Map<String, List<AnalyticsModel>> monthlyData;
  final String selectedMonth;
  final int? selectedBarIndex;
  final Widget Function(double, TitleMeta) bottomTitles;
  const GraficLineAnalyticsWidget({
    super.key,
    required this.monthlyData,
    required this.selectedMonth,
    this.selectedBarIndex,
    required this.bottomTitles,
  });

  @override
  State<GraficLineAnalyticsWidget> createState() =>
      _GraficLineAnalyticsWidgetState();
}

class _GraficLineAnalyticsWidgetState extends State<GraficLineAnalyticsWidget> {
  late List<BarChartGroupData> barGroups;
  int? selectedBarIndex;
  void filterData() {
    if (!widget.monthlyData.containsKey(widget.selectedMonth) ||
        widget.monthlyData[widget.selectedMonth]!.isEmpty) {
      setState(() {
        barGroups = [];
      });
      return;
    }

    List<AnalyticsModel> analyticsData =
        widget.monthlyData[widget.selectedMonth]!;
    analyticsData.sort((a, b) => a.day.compareTo(b.day));

    barGroups =
        analyticsData.asMap().entries.map((entry) {
          int index = entry.key;
          AnalyticsModel data = entry.value;
          double progress = data.progress;
          double meta = double.tryParse(data.meta) ?? 0.0;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: meta,
                color: AppColors.grey,
                width: widget.selectedBarIndex == index ? 14 : 10,
                borderRadius: BorderRadius.circular(4),
              ),
              BarChartRodData(
                toY: progress,
                color: AppColors.blueOne,
                width: widget.selectedBarIndex == index ? 14 : 10,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
            barsSpace: 5,
          );
        }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          barTouchData: BarTouchData(
            enabled: true,
            touchCallback: (event, response) {
              if (response != null && response.spot != null) {
                setState(() {
                  selectedBarIndex = response.spot!.touchedBarGroupIndex;
                  filterData();
                });
              }
            },
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: EdgeInsets.all(8),
              tooltipRoundedRadius: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Valor: ${rod.toY.toStringAsFixed(1)}',
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: widget.bottomTitles,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: barGroups,
        ),
      ),
    );
  }
}
