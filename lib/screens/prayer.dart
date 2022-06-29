import 'package:adhan/adhan.dart';
import 'package:almuslim/modules/constants.dart';
import 'package:almuslim/widgets/prayer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class Prayer extends StatelessWidget {
  final Box box;
  final LocationData locationData;
  final List<geo.Placemark> placemarks;

  Prayer({Key key, this.locationData, this.placemarks, this.box})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (box.get('calculationMethod') == null) {
      box.put('calculationMethod', defaultCalculationMethod);
    }
    var method = box.get('calculationMethod');

    if (box.get('madhab') == null) {
      box.put('madhab', defaultMadhab);
    }
    var madhab = box.get('madhab');
    print(madhab);
    if (box.get('highLatitudeRule') == null) {
      box.put('highLatitudeRule', defaultHighLatitudeRule);
    }
    var highLatitudeRule = box.get('highLatitudeRule');
    print(highLatitudeRule);
    PrayerTimes pTimes = getPrayerTimes(
        Coordinates(locationData.latitude, locationData.longitude),
        method,
        madhab,
        highLatitudeRule);
    print(pTimes);
    print(pTimes);
    var theme = this.box.get('theme');
    return Scaffold(
      backgroundColor: themeSet[theme]["backgroundColor"],
      appBar: AppBar(
        title: Text("Prayer times"),
        backgroundColor: baseGreenColor,
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                PrayerHeading(
                  headingTitle: "Prayer times",
                  placemarks: placemarks,
                ),
                PrayerColumn(
                  waqt: "Fajr",
                  waqtPrayerTime: pTimes.fajr,
                  icon: Icons.wb_sunny_outlined,
                ),
                PrayerColumn(
                  waqt: "Sunrise",
                  waqtPrayerTime: pTimes.sunrise,
                  icon: Icons.sunny,
                ),
                PrayerColumn(
                  waqt: "Duhr",
                  waqtPrayerTime: pTimes.dhuhr,
                  icon: Icons.wb_sunny,
                ),
                PrayerColumn(
                  waqt: "Asr",
                  waqtPrayerTime: pTimes.asr,
                  icon: Icons.wb_sunny,
                ),
                PrayerColumn(
                  waqt: "Maghrib",
                  waqtPrayerTime: pTimes.maghrib,
                  icon: Icons.cloud_queue,
                ),
                PrayerColumn(
                  waqt: "Isha",
                  waqtPrayerTime: pTimes.isha,
                  icon: Icons.wb_cloudy_rounded,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

PrayerTimes getPrayerTimes(
    Coordinates myCoordinates, String calculationMethod, String madhab, String highLatitudeRule) {
  CalculationParameters params =
      CalculationMethod.values.byName(calculationMethod).getParameters();
  // add angle based method
  params.highLatitudeRule = HighLatitudeRule.values.byName(highLatitudeRule);

  if (madhab == Madhab.shafi.toString()) {
    params.madhab = Madhab.shafi;
  } else {
    params.madhab = Madhab.hanafi;
  }

  return PrayerTimes.today(myCoordinates, params);
}

Future<Location> getLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  /*LocationData _locationData;
  _locationData = await location.getLocation();*/

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

  return location;
}
