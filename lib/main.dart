import 'dart:io';
import 'package:adhan/adhan.dart';
import 'package:almuslim/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';
import 'package:almuslim/data/quran.dart';
import 'dart:math';
import 'package:almuslim/models/constants.dart';
import 'package:location/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Random random = new Random();
  int randomNumber = 1 + random.nextInt(TotalAyah - 1);
  print("Random Ayah number: ${randomNumber}");

  var box = await Hive.openBox("almuslim");
  box.put('dailyAyah', randomNumber.toString());

  // Location
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  LocationData _locationData;
  _locationData = await location.getLocation();

  runApp(new MaterialApp(
    home: Provider<DBProvider>(
      create: (_) => DBProvider(),
      child: HomeView(
        box: box,
        locationData: _locationData,
      ),
    ),
  ));
}
