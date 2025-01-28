import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/features/goals/goalspage.dart';
import 'package:aquify_app/features/goals/newgoals/newgoalspage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageAtual = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageAtual);
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
        children: [GoalsPage(), NewGoalsPage()],
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
          pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
