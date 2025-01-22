import 'package:aquify_app/common/constants/routes.dart';
import 'package:aquify_app/features/home/homepage.dart';
import 'package:flutter/material.dart';

import 'features/onboarding/onboardingpage.dart';
import 'features/splash/splashpage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context) => OnboardingPage(),
        NamedRoute.splash: (context) => SplashPage(),
        NamedRoute.signIn: (context) => SplashPage(),
        NamedRoute.signUp: (context) => SplashPage(),
        NamedRoute.home: (context) => HomePage(),
      },
    );
  }
}
