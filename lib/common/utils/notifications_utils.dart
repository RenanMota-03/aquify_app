import 'package:aquify_app/common/models/goals_model.dart';
import 'package:aquify_app/locator.dart';
import '../../features/goals/goal_controller.dart';
import '../../services/notification_service.dart';

final _goalController = locator.get<GoalController>();
final notificationService = NotificationService();

Future<void> loadNotification() async {
  await notificationService.initNotification();

  GoalsModel? goal = await _goalController.getGoal();
  if (goal?.listHour != null && goal!.listHour!.isNotEmpty) {
    await notificationService.scheduleDailyNotifications(goal.listHour!);
  }
}
