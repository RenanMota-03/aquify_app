import 'package:aquify_app/features/splash/splash_controller.dart';
import 'package:aquify_app/services/firebase_auth_service.dart';
import 'package:aquify_app/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'features/sign_in/sign_in_controller.dart';
import 'features/sign_up/sign_up_controller.dart';
import 'services/auth_service.dart';

final locator = GetIt.instance;
void setupDependencies() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  locator.registerFactory<SignInController>(
    () => SignInController(locator.get<AuthService>(), SecureStorage()),
  );
  locator.registerFactory<SignUpController>(
    () => SignUpController(locator.get<AuthService>()),
  );
  locator.registerFactory<SplashController>(
    () => SplashController(const SecureStorage()),
  );
}
