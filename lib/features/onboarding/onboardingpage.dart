import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/constants/routes.dart';
import 'package:aquify_app/common/widgets/multi_text_button.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Expanded(child: Image.asset('assets/images/onboarding_image.png')),
            Text(
              "Hidrate-se com um toque",
              style: AppTextStyles.mediumText30.copyWith(
                color: AppColors.blueOne,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
              child: Column(
                children: [
                  PrimaryButton(
                    text: "Comece agora",
                    onPressed: () {
                      Navigator.pushNamed(context, NamedRoute.signUp);
                    },
                  ),
                  SizedBox(height: 10),
                  MultiTextButton(
                    children: [
                      Text(
                        "Já possui uma conta? ",
                        style: AppTextStyles.smallText,
                      ),
                      Text(
                        "Clique aqui",
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.blueTwo,
                        ),
                      ),
                    ],
                    onPressed: () {
                      Navigator.pushNamed(context, NamedRoute.signIn);
                    },
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
