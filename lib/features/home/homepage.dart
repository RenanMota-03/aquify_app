import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/features/goals/goalpage.dart';
import 'package:aquify_app/features/newgoals/newgoals_state.dart';
import 'package:aquify_app/features/newgoals/newgoalspage.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../newgoals/newgoals_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listQuantidade = [
    "200",
    "300",
    "400",
    "500",
    "600",
    "700",
    "800",
  ];
  int pageAtual = 0;
  final _controllerNewGoal = locator.get<NewGoalsController>();
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: pageAtual);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controllerNewGoal.state is NewGoalsStateSuccess) {
        setPageAtual(pageAtual - 1);
      }
    });
  }

  setPageAtual(page) {
    setState(() {
      pageAtual = page;
    });
  }

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

      body: PageView(
        controller: pageController,
        onPageChanged: setPageAtual,
        children: [
          GoalsPage(listQtd: listQuantidade),
          NewGoalsPage(listQuantidade: listQuantidade),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageAtual,
        backgroundColor: AppColors.blueOne,
        selectedLabelStyle: AppTextStyles.smallText,
        unselectedLabelStyle: AppTextStyles.smallText,
        selectedItemColor: AppColors.iceWhite,
        unselectedItemColor: AppColors.grey,
        selectedIconTheme: IconThemeData(color: AppColors.iceWhite),
        unselectedIconTheme: IconThemeData(color: AppColors.grey),

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.water_damage),
            label: "Inicio",
            tooltip: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Nova Meta",
            tooltip: "Nova Meta",
          ),
        ],
        onTap: (page) {
          if (page != pageAtual) {
            setPageAtual(page);
            pageController.animateToPage(
              page,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          }
        },
      ),
    );
  }
}
