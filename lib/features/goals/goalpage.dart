import 'package:flutter/material.dart';
import '../../common/widgets/custom_background_container.dart';
import '../../common/widgets/grafic_circular.dart';
import '../../common/widgets/primary_button.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalspageState();
}

class _GoalspageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: CustomBackgroundContainer(
          child: Column(
            children: [
              AspectRatio(aspectRatio: 1, child: GraficCircularWidget()),

              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [PrimaryButton(text: "Beber", onPressed: () {})],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
