import 'package:adhan/adhan.dart';
import 'package:almuslim/widgets/prayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Prayer extends StatelessWidget {
  PrayerTimes pTimes = getPrayerTimes(Coordinates(61.44480082215663, 23.853269454564234));

  // Location Starts


  // Location Ends

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Prayer times"
        ),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                PrayerHeading(headingTitle: "Prayer times",),
                PrayerColumn(waqt: "Fajr", waqtPrayerTime: pTimes.fajr, icon: Icons.wb_sunny_outlined,),
                PrayerColumn(waqt: "Duhr", waqtPrayerTime: pTimes.dhuhr, icon: Icons.wb_sunny,),
                PrayerColumn(waqt: "Asr", waqtPrayerTime: pTimes.asr, icon: Icons.wb_sunny,),
                PrayerColumn(waqt: "Maghrib", waqtPrayerTime: pTimes.maghrib, icon: Icons.cloud_queue,),
                PrayerColumn(waqt: "Isha", waqtPrayerTime: pTimes.isha, icon: Icons.wb_cloudy_rounded,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

PrayerTimes getPrayerTimes(Coordinates myCoordinates){ // Replace with your own location lat, lng.
  CalculationParameters params = CalculationMethod.karachi.getParameters();
  params.madhab = Madhab.hanafi;
  return PrayerTimes.today(myCoordinates, params);
}

Future<Location> getLocation() async{
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