import 'dart:developer';

import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/widgets/grafic_circular/grafic_circular_controller.dart';
import 'package:flutter/material.dart';
import '../../common/models/goals_model.dart';
import '../../common/widgets/custom_background_container.dart';
import '../../common/widgets/grafic_circular.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';
import 'goal_controller.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalspageState();
}

class _GoalspageState extends State<GoalsPage> {
  double qtdbebida = 0.0;
  double progress = 0;
  final _goalController = locator.get<GoalController>();
  final _gcController = locator.get<GraficCircularController>();
  late List<DateTime> listHorario;
  DateTime? nowGoal;
  GoalsModel? _goal;
  void _loadGoalData() async {
    GoalsModel? goal = await _goalController.getGoal();
    setState(() {
      _goal = goal;
    });
  }

  @override
  void initState() {
    listHorario = _gcController.horario;
    nowGoal = _gcController.now;
    log(listHorario.toString());
    _loadGoalData();
    _verifyRemocao();
    super.initState();
  }

  void _verifyRemocao() {
    listHorario = _gcController.horarios;
    nowGoal = _gcController.now;
    if (listHorario.isNotEmpty && listHorario.first == nowGoal) {
      setState(() {
        listHorario.removeAt(0);
      });
      log(listHorario.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    listHorario = _gcController.horarios;
    nowGoal = _gcController.now;
    if (_goal?.quantidadeMl != null) {
      qtdbebida = double.parse(_goal!.quantidadeMl!) / 1000;
    }
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
                        setState(() {
                          progress += qtdbebida;
                        });
                      },
                    ),
                  ],
                ),
              ),
              listHorario.isEmpty
                  ? Text("Todos os Horários passaram")
                  : ListView.builder(
                    shrinkWrap: true,
                    itemCount: listHorario.length > 5 ? 5 : listHorario.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        child: Text(
                          "Horario para tomar: ${listHorario[index]}",
                          style: AppTextStyles.mediumText18,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
