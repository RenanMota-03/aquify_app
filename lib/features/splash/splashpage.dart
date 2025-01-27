import 'dart:developer';

import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:aquify_app/features/splash/splash_controller.dart';
import 'package:aquify_app/locator.dart';
import 'package:flutter/material.dart';

import '../../common/constants/routes.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _splashController = locator.get<SplashController>();

  @override
  void initState() {
    super.initState();
    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is SplashStateSuccess) {
        Navigator.pushReplacementNamed(context, NamedRoute.home);
        log('navegar para home');
      } else {
        Navigator.pushReplacementNamed(context, NamedRoute.initial);
        log('navegar para onboarding');
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
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
