import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import '../../common/models/goals_model.dart';
import '../../common/utils/goal_utils.dart';
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
  DateTime now = DateTime.now();
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
    });
  }

  @override
  void initState() {
    super.initState();
    _loadGoalData();
  }

  @override
  void dispose() {
    super.dispose();
    _goalController.dispose();
    _modalDropController.dispose();
  }

  void registerConsumption() {
    setState(() {
      String hourAtual = "${DateTime.now().hour}:${DateTime.now().minute}";

      if (withinMarginDelay(hourAtual)) {
        consumedTimes.add(hourAtual);
      }
      progress += double.parse(_modalDropController.text) / 1000;

      setState(() {
        _goalController.isDay(progressgoal: progress);
      });

      log(progress.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: CustomBackgroundContainer(
          child: ListView(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      (_goal?.listHour ?? [])
                          .map(
                            (item) => Text(
                              "Horário de Beber: $item",
                              style: AppTextStyles.smallText.copyWith(
                                color: defineTimeColor(
                                  nextHour: item,
                                  consumedTimes: consumedTimes,
                                ),
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
