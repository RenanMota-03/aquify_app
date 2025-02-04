import 'package:aquify_app/features/goals/goal_controller.dart';
import 'package:aquify_app/features/newgoals/newgoals_controller.dart';
import 'package:aquify_app/features/splash/splash_controller.dart';
import 'package:aquify_app/services/firebase_auth_service.dart';
import 'package:aquify_app/services/goals_service.dart';
import 'package:aquify_app/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'features/sign_in/sign_in_controller.dart';
import 'features/sign_up/sign_up_controller.dart';
import 'services/auth_service.dart';
import 'services/goal_service_impl.dart';

final locator = GetIt.instance;
void setupDependencies() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  locator.registerLazySingleton<GoalsService>(() => NewGoalsServiceImpl());
  locator.registerFactory<SignInController>(
    () => SignInController(locator.get<AuthService>(), SecureStorage()),
  );
  locator.registerFactory<SignUpController>(
    () => SignUpController(locator.get<AuthService>()),
  );
  locator.registerFactory<SplashController>(
    () => SplashController(const SecureStorage()),
  );
  locator.registerFactory<GoalController>(
    () => GoalController(const SecureStorage(), locator.get<GoalsService>()),
  );
  locator.registerFactory<NewGoalsController>(
    () => NewGoalsController(locator.get<GoalsService>()),
  );
}
