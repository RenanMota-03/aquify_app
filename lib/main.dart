import 'dart:async';
import 'package:aquify_app/common/utils/notifications_utils.dart';
import 'package:aquify_app/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'locator.dart';

@pragma('vm:entry-point')
void alarmCallback() {
  NotificationService.triggerNotification();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();
  await AndroidAlarmManager.initialize();
  final notificationService = NotificationService();
  await notificationService.initNotification();
  loadNotification();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await AndroidAlarmManager.initialize();

  runApp(ProviderScope(child: const App()));
}
