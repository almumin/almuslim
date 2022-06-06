import 'package:almuslim/modules/notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

class Reminders extends StatefulWidget {
  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                NotificationService().cancelAllNotifications();
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Cancel All Notifications",
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                NotificationService().showScheduledNotification(1, "📿 Al Muslim", "  Prayer time for Isha", 3);
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                      "Show Notification"
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
