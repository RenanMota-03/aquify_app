import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset('assets/images/onboarding_image.jpeg'),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Mantenha-se hidratado",
                    style: AppTextStyles.mediumText.copyWith(
                      color: AppColors.blueOne,
                    ),
                  ),
                  Text(
                    "Cuide do seu bem-estar!",
                    style: AppTextStyles.mediumText.copyWith(
                      color: AppColors.blueOne,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
