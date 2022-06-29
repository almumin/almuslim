import 'dart:io';

import 'package:adhan/adhan.dart';

import 'package:almuslim/database/store.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/app-context-hive.dart';
import '../screens/prayer.dart';
import 'constants.dart';
import 'notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class BackgroundTasks {
  Future<bool> runHourlyBackgroundTask(inputData) async {
    print("pTimes.nextPrayer()");
    print("$hourlyScheduledTask was executed. inputData = $inputData");

    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    var box = await Hive.openBox("almuslim");
    ApplicationContext a = ApplicationContext(
      madhab: defaultMadhab,
      highLatitudeRule: defaulthighLatitudeRule,
      calculationMethod: defaultCalculationMethod
    );
    box.put("appContext", a.toJson());
    ApplicationContext appContext =
        ApplicationContext.fromJson(box.get('appContext'));

    String madhab =
        appContext.madhab != null ? appContext.madhab : defaultMadhab;
    String highLatitudeRule = appContext.highLatitudeRule != null
        ? appContext.highLatitudeRule
        : defaulthighLatitudeRule;
    String calculationMethod = appContext.calculationMethod != null
        ? appContext.calculationMethod
        : defaultCalculationMethod;

    PrayerTimes pTimes = getPrayerTimes(
        Coordinates(inputData["latitude"], inputData["longitude"]),
        calculationMethod,
        madhab,
        highLatitudeRule);

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
