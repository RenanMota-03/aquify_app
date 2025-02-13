import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/models/goals_model.dart';
import 'package:aquify_app/common/models/updategoal_model.dart';
import 'package:aquify_app/features/analytics/analyticspage.dart';
import 'package:aquify_app/features/goals/goalpage.dart';
import 'package:aquify_app/features/newgoals/newgoals_state.dart';
import 'package:aquify_app/features/newgoals/newgoalspage.dart';
import 'package:flutter/material.dart';
import '../../common/utils/notifications_utils.dart';
import '../../locator.dart';

import '../analytics/analytics_controller.dart';
import '../goals/goal_controller.dart';
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
  final _goalController = locator.get<GoalController>();
  final _analyticsController = locator.get<AnalyticsController>();
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    _initialize();
    pageController = PageController(initialPage: pageAtual);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controllerNewGoal.state is NewGoalsStateSuccess) {
        setPageAtual(pageAtual - 1);
      }
    });
  }

  Future<void> resetGoal() async {
    UpdateGoalModel? day = await _goalController.getDay();
    GoalsModel? goal = await _goalController.getGoal();
    DateTime date = DateTime.parse(day?.now ?? DateTime.now().toString());
    setState(() {
      if (date.day < now.day && date.month == now.month) {
        if (goal?.metaL != null && day?.progressgoal != null) {
          _analyticsController.saveAnalyticsData(
            now.toString(),
            goal!.metaL!,
            day!.progressgoal,
          );
        }
        _goalController.isDay(
          now: now.toString(),
          progressgoal: 0.0,
          selectedTimes: {},
        );
      } else if (date.month != now.month) {
        if (goal?.metaL != null && day?.progressgoal != null) {
          _analyticsController.saveAnalyticsData(
            now.toString(),
            goal!.metaL!,
            day!.progressgoal,
          );
        }
        _goalController.isDay(
          now: now.toString(),
          progressgoal: 0.0,
          selectedTimes: {""},
        );
      }
    });
  }

  void _initialize() async {
    await resetGoal();
    await loadNotification();
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
          AnalyticsPage(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Analytics",
            tooltip: "Análises",
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
