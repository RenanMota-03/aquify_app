import 'dart:developer';
import 'dart:typed_data';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  NotificationService._internal();

  Future<void> initNotification() async {
    if (_isInitialized) return;
    _isInitialized = true;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(android: androidInit, iOS: iosInit);
    await _notificationsPlugin.initialize(settings);

    await _createNotificationChannel();
    await requestPermissions();
  }

  Future<void> requestPermissions() async {
    final androidPlugin =
        _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidPlugin?.requestNotificationsPermission();
  }

  Future<void> _createNotificationChannel() async {
    final channel = AndroidNotificationChannel(
      'daily_channel_id',
      'Daily Notifications',
      description: 'Daily water reminders',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> scheduleDailyNotifications(List<String> horarios) async {
    await _notificationsPlugin.cancelAll();

    if (horarios.isEmpty) {
      log("Nenhum horário encontrado para agendar notificações.");
      return;
    }

    for (int i = 0; i < horarios.length; i++) {
      final timeParts = horarios[i].split(':');

      if (timeParts.length != 2) {
        log("Formato inválido para horário: ${horarios[i]}");
        continue;
      }

      try {
        final int hour = int.parse(timeParts[0]);
        final int minute = int.parse(timeParts[1]);

        final now = DateTime.now();
        var scheduledTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );

        if (scheduledTime.isBefore(now)) {
          scheduledTime = scheduledTime.add(const Duration(days: 1));
        }

        final int alarmId = i + 1;

        await AndroidAlarmManager.oneShotAt(
          scheduledTime,
          alarmId,
          triggerNotification,
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
        );
      } catch (e) {
        log("Erro ao processar horário: ${horarios[i]} -> $e");
      }
    }
  }

  @pragma('vm:entry-point')
  static void triggerNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'notificacao_channel',
          'Hora de beber água 💧',
          channelDescription: 'Beba um copo de água para se manter hidratado!',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Hora de beber água 💧',
      'Beba um copo de água para se manter hidratado!',
      notificationDetails,
    );
  }
}
