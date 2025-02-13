import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/widgets/custom_background_container.dart';
import 'package:aquify_app/common/widgets/grafic_line_analytics_widget.dart';
import 'package:aquify_app/features/analytics/analytics_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import 'package:intl/intl.dart';
import '../../common/models/analytics_model.dart';
import '../../common/utils/analytics_utils.dart';
import '../../locator.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final _analyticsController = locator.get<AnalyticsController>();
  Map<String, List<AnalyticsModel>> monthlyData = {};
  String selectedMonth = '';
  List<BarChartGroupData> barGroups = [];
  int? selectedBarIndex;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      List<AnalyticsModel>? analyticsGet =
          await _analyticsController.fetchAnalyticsData();

      if (analyticsGet.isNotEmpty) {
        organizeDataByMonth(analyticsGet, monthlyData);

        if (!mounted) return;

        setState(() {
          selectedMonth = monthlyData.keys.last;
          filterData();
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar dados do Firestore: $e');
    }
  }

  void filterData() {
    if (!monthlyData.containsKey(selectedMonth) ||
        monthlyData[selectedMonth]!.isEmpty) {
      setState(() {
        barGroups = [];
      });
      return;
    }

    List<AnalyticsModel> analyticsData = monthlyData[selectedMonth]!;
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
                width: selectedBarIndex == index ? 14 : 10,
                borderRadius: BorderRadius.circular(4),
              ),
              BarChartRodData(
                toY: progress,
                color: AppColors.blueOne,
                width: selectedBarIndex == index ? 14 : 10,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
            barsSpace: 5,
          );
        }).toList();

    setState(() {});
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    int index = value.toInt();
    if (index < 0 || index >= monthlyData[selectedMonth]!.length) {
      return Container();
    }
    String text = DateFormat(
      'dd/MM',
    ).format(DateTime.parse(monthlyData[selectedMonth]![index].day));
    return SideTitleWidget(meta: meta, child: Text(text, style: style));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Análises de Água Bebida:",
              style: AppTextStyles.mediumText18.copyWith(
                color: AppColors.iceWhite,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropdownButton<String>(
                value: selectedMonth,
                items:
                    monthlyData.keys.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(
                          month,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                onChanged: (newMonth) {
                  if (newMonth != null) {
                    setState(() {
                      selectedMonth = newMonth;
                      filterData();
                    });
                  }
                },
              ),
            ),
            GraficLineAnalyticsWidget(
              monthlyData: monthlyData,
              selectedMonth: selectedMonth,
              bottomTitles: bottomTitles,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.square, color: AppColors.blueOne),
                  SizedBox(width: 5),
                  Text("Progresso"),
                  SizedBox(width: 15),
                  Icon(Icons.square, color: AppColors.grey),
                  SizedBox(width: 5),
                  Text("Meta"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
