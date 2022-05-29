import 'dart:io';
import 'package:almuslim/models/app-context.dart';
import 'package:almuslim/screens/home.dart';
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

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerOneOffTask("task-identifier", "simpleTask");


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
