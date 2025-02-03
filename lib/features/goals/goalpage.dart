import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import '../../common/models/goals_model.dart';
import '../../common/widgets/custom_background_container.dart';
import '../../common/widgets/custom_dropdown_sheet.dart';
import '../../common/widgets/grafic_circular.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';
import 'goal_controller.dart';

class GoalsPage extends StatefulWidget {
  final List<String> listQtd;
  const GoalsPage({super.key, required this.listQtd});

  @override
  State<GoalsPage> createState() => _GoalspageState();
}

class _GoalspageState extends State<GoalsPage> {
  double qtdbebida = 0.0;
  double progress = 0;
  final _goalController = locator.get<GoalController>();
  final TextEditingController _modalDropController = TextEditingController();

  GoalsModel? _goal;
  Set<String> consumedTimes = {};
  String? delayedConsumedTime;
  void _loadGoalData() async {
    GoalsModel? goal = await _goalController.getGoal();
    setState(() {
      _goal = goal;
      log("Teste lista:${_goal?.listHour.toString()}");
    });
  }

  @override
  void initState() {
    _loadGoalData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _goalController.dispose();
    _modalDropController.dispose();
  }

  DateTime _parseNextHour(String nextHour) {
    final now = DateTime.now();
    final parts = nextHour.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  bool withinMarginDelay(String nextHour) {
    final nextHourDateTime = _parseNextHour(nextHour);
    final now = DateTime.now();
    return now.isBefore(nextHourDateTime.add(const Duration(minutes: 5)));
  }

  bool timeHasPassed(String nextHour) {
    final nextHourDateTime = _parseNextHour(nextHour);
    return DateTime.now().isAfter(
      nextHourDateTime.add(const Duration(minutes: 5)),
    );
  }

  Color defineTimeColor(String nextHour) {
    if (consumedTimes.contains(nextHour)) {
      return Colors.green;
    } else if (timeHasPassed(nextHour)) {
      return AppColors.error;
    }
    return AppColors.blueOne;
  }

  void registerConsumption() {
    setState(() {
      String hourAtual = "${DateTime.now().hour}:${DateTime.now().minute}";

      if (withinMarginDelay(hourAtual)) {
        consumedTimes.add(hourAtual);
      }
      progress += double.parse(_modalDropController.text) / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: CustomBackgroundContainer(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GraficCircularWidget(progress: progress),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    PrimaryButton(
                      text: "Beber",
                      onPressed: () {
                        customDropdownBottomSheet(
                          context,
                          buttonText: "Beber",
                          content: "Coloque a quantidade de água",
                          controller: _modalDropController,
                          hintText: "Quantidade bebida em ML",
                          list: widget.listQtd,
                          onPressed: registerConsumption,
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      (_goal?.listHour ?? [])
                          .map(
                            (item) => Text(
                              "Horário de Beber: $item",
                              style: AppTextStyles.smallText.copyWith(
                                color: defineTimeColor(item),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
