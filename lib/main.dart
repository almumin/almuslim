import 'dart:io';
import 'package:adhan/adhan.dart';
import 'package:almuslim/extensions/string.dart';
import 'package:almuslim/models/app-context.dart';
import 'package:almuslim/modules/constants.dart';
import 'package:almuslim/screens/home.dart';
import 'package:almuslim/screens/prayer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';
import 'package:almuslim/data/quran.dart';
import 'dart:math';
import 'package:almuslim/models/constants.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:workmanager/workmanager.dart';
import 'database/store.dart';
import 'models/quran-entity.dart';
import 'modules/notifications.dart';
import 'objectbox.g.dart';
import 'package:timezone/data/latest.dart' as tz;

const hourlyScheduledTask = "hourlyScheduledTask";
const weeklyScheduledTask = "weeklyScheduledTask";
const monthlyScheduledTask = "monthlyScheduledTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case hourlyScheduledTask:
        print("pTimes.nextPrayer()");
        print("$hourlyScheduledTask was executed. inputData = $inputData");

        PrayerTimes pTimes = getPrayerTimes(
            Coordinates(inputData["latitude"], inputData["longitude"]),
            inputData["calculationMethod"],
            inputData["madhab"],
            inputData["highLatitudeRule"]);

        print(pTimes.nextPrayer());
        print(pTimes.timeForPrayer(pTimes.nextPrayer()));
        var timeToNextPrayer = pTimes.timeForPrayer(pTimes.nextPrayer()).difference(DateTime.now());
        print(timeToNextPrayer);
        print(timeToNextPrayer.inSeconds);
        tz.initializeTimeZones();
        NotificationService().cancelAllNotifications();
        NotificationService().showNotification(1, "📿 Al Muslim", "  Prayer time for " + pTimes.nextPrayer().name.toCapitalized(), timeToNextPrayer.inSeconds);
        break;
      case weeklyScheduledTask:
        print("$weeklyScheduledTask was executed. inputData = $inputData");
        break;
      case monthlyScheduledTask:
        print("$monthlyScheduledTask was executed. inputData = $inputData");
        return Future.value(true);
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  print(DateTime.now());
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Random random = new Random();
  int randomNumber = 1 + random.nextInt(TotalAyah - 1);
  print("Random Ayah number: $randomNumber");

  var box = await Hive.openBox("almuslim");
  box.put('dailyAyah', randomNumber.toString());

  var objectBox = await ObjectBox.create();

  // Location Starts
  loc.Location location = new loc.Location();
  bool _serviceEnabled;
  loc.PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == loc.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != loc.PermissionStatus.granted) {
      return null;
    }
  }

  loc.LocationData _locationData;
  _locationData = await location.getLocation();
  // Location Ends

  // GEOLocation Starts ## package geolocator is in pubspec but not used anywhere
  List<Placemark> placemarks = await placemarkFromCoordinates(
      _locationData.latitude, _locationData.longitude);
  // GEOLocation Ends

  // Work manager Initialization starts here
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().cancelAll();
  Workmanager().registerPeriodicTask(
    hourlyScheduledTask,
    hourlyScheduledTask,
    initialDelay: Duration(seconds: 10),
    frequency: Duration(minutes: 15),
    inputData: {
      'latitude': _locationData.latitude,
      'longitude': _locationData.longitude,
      'madhab': box.get('madhab') != null ? box.get('madhab') : defaultMadhab,
      'highLatitudeRule': box.get('highLatitudeRule') != null ? box.get('highLatitudeRule') : defaulthighLatitudeRule,
      'calculationMethod': box.get('calculationMethod') != null ? box.get('calculationMethod') : defaultCalculationMethod,
    },
  );

  runApp(StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return new MaterialApp(
          home: Provider<DBProvider>(
            create: (_) => DBProvider(),
            child: HomeView(
              box: box,
              locationData: _locationData,
              placemarks: placemarks,
              objectBox: objectBox,
            ),
          ),
        );
      }));
}


