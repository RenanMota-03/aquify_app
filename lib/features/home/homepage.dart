import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/grafic_circular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int touchedIndex = -1;
  double graficoValor = 0;
  String graficoLabel = 'Meta';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Aquify",
            style: AppTextStyles.mediumText30.copyWith(color: AppColors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.blue3Gradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Align(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.blueGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GraficCircularWidget(onSectionTouched: setGraficoDados),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: TextStyle(fontSize: 20, color: Colors.teal),
                  ),
                  Text("$graficoValor", style: TextStyle(fontSize: 28)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  setGraficoDados(index) {
    if (index < 0) {
      graficoLabel = 'Meta';
      graficoValor = 0;
    } else if (index == 1) {
      graficoLabel = 'Saldo';
      graficoValor = 123;
    } else {
      graficoLabel = "Teste";
      graficoValor = 12;
    }
  }
}
