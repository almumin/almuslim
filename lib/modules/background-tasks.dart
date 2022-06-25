import 'dart:io';

import 'package:adhan/adhan.dart';

import 'package:almuslim/database/store.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../screens/prayer.dart';
import 'notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class BackgroundTasks {
  Future<bool> runHourlyBackgroundTask(inputData) async {
    print("pTimes.nextPrayer()");
    print("$hourlyScheduledTask was executed. inputData = $inputData");

    PrayerTimes pTimes = getPrayerTimes(
        Coordinates(inputData["latitude"], inputData["longitude"]),
        inputData["calculationMethod"],
        inputData["madhab"],
        inputData["highLatitudeRule"]);

    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    var box = await Hive.openBox("almuslim");
    print(box.get("madhab"));

    var nextPrayerTime = pTimes.timeForPrayer(pTimes.nextPrayer());
    var timeToNextPrayer = nextPrayerTime.difference(DateTime.now());
    tz.initializeTimeZones();
    print(timeToNextPrayer.inSeconds);
    NotificationService().showScheduledNotification(
        1,
        toBeginningOfSentenceCase(pTimes.nextPrayer().name) +
            " at " +
            DateFormat('HH:mm').format(nextPrayerTime),
        "📿 see prayer times",
        timeToNextPrayer.inSeconds);

    return Future.value(true);
  }
}
