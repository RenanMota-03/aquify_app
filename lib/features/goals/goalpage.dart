import 'package:flutter/material.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import '../../common/models/goals_model.dart';
import '../../common/models/updategoal_model.dart';
import '../../common/utils/goal_utils.dart';
import '../../common/widgets/custom_background_container.dart';
import '../../common/widgets/custom_dropdown_sheet.dart';
import '../../common/widgets/grafic_circular.dart';
import '../../common/widgets/labeled_checkbox_widget.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';
import 'goal_controller.dart';

class GoalsPage extends StatefulWidget {
  final List<String> listQtd;
  const GoalsPage({super.key, required this.listQtd});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final _goalController = locator.get<GoalController>();
  final TextEditingController _modalDropController = TextEditingController();

  GoalsModel? _goal;
  Set<String> selectedTimes = {};
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadGoalData();
  }

  @override
  void dispose() {
    _goalController.dispose();
    _modalDropController.dispose();
    super.dispose();
  }

  Future<void> _loadGoalData() async {
    GoalsModel? goal = await _goalController.getGoal();
    UpdateGoalModel? getProgress = await _goalController.getDay();

    setState(() {
      _goal = goal;
      selectedTimes = getProgress?.selectedTimes ?? {};
      progress = getProgress?.progressgoal ?? 0.0;
    });
  }

  void _registerConsumption() async {
    UpdateGoalModel? getProgress = await _goalController.getDay();
    if (_modalDropController.text.isNotEmpty) {
      setState(() {
        progress += double.parse(_modalDropController.text) / 1000;
        _goalController.isDay(
          progressgoal: progress,
          selectedTimes: selectedTimes,
          now: getProgress?.now,
        );
      });
    }
  }

  void _toggleSelectedTime(String time, bool? value) async {
    UpdateGoalModel? getProgress = await _goalController.getDay();
    setState(() {
      if (value == true) {
        selectedTimes.add(time);
      } else {
        selectedTimes.remove(time);
      }
      _goalController.isDay(
        progressgoal: progress,
        selectedTimes: selectedTimes,
        now: getProgress?.now,
      );
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
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PrimaryButton(
                  text: "Beber",
                  onPressed: () {
                    customDropdownBottomSheet(
                      context,
                      buttonText: "Beber",
                      content: "Coloque a quantidade de água",
                      controller: _modalDropController,
                      hintText: "Quantidade bebida em ML",
                      list: widget.listQtd,
                      onPressed: _registerConsumption,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      (_goal?.listHour ?? []).map((item) {
                        return LabeledCheckboxWidget(
                          label: Text(
                            "Horário de Beber: $item",
                            style: AppTextStyles.mediumText20.copyWith(
                              color: defineTimeColor(
                                isSelected: selectedTimes.contains(item),
                                nextHour: item,
                              ),
                            ),
                          ),
                          value: selectedTimes.contains(item),
                          onChanged:
                              (value) => _toggleSelectedTime(item, value),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
