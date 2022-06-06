import 'package:awesome_notifications/awesome_notifications.dart';

// TODO: implement awesome notification
class AwesomeNotificationService {
  Future<void> initNotification() async {
    AwesomeNotifications().initialize('resource://drawable/notification_icon', [
      // notification icon
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
      ),
    ]);
  }

  Future<void> showScheduledNotification(
      int id, String title, String body, int seconds) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          //simgple notification
          id: id,
          channelKey: 'basic', //set configuration wuth key "basic"
          title: title,
          body: body,
          payload: {"name": "FlutterCampus"},
          autoDismissible: false,
        ),
        schedule: NotificationCalendar.fromDate(date: DateTime.now().add(Duration(seconds: seconds))),
        actionButtons: [
          NotificationActionButton(
            key: "open",
            label: "Open File",
          ),
          NotificationActionButton(
            key: "delete",
            label: "Delete File",
          )
        ]);
  }
}
