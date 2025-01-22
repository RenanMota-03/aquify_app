import 'dart:async';

import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

import '../../common/constants/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Timer init() {
    return Timer(Duration(seconds: 3), navigateToHome);
  }

  void navigateToHome() {
    Navigator.pushReplacementNamed(context, NamedRoute.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.blue2Gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aquify",
              style: AppTextStyles.bigText.copyWith(color: AppColors.white),
            ),
            CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
