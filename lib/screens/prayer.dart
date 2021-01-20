import 'package:adhan/adhan.dart';
import 'package:almuslim/widgets/prayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Prayer extends StatelessWidget {
  PrayerTimes pTimes = getPrayerTimes(Coordinates(61.44480082215663, 23.853269454564234));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer times"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.green.shade400,
            child: Column(
              children: [
                PrayerHeading(headingTitle: "Prayer times",),
                PrayerColumn(waqt: "Fajr", waqtPrayerTime: pTimes.fajr, icon: Icons.wb_sunny_outlined,),
                PrayerColumn(waqt: "Duhr", waqtPrayerTime: pTimes.dhuhr, icon: Icons.wb_sunny,),
                PrayerColumn(waqt: "Asr", waqtPrayerTime: pTimes.asr, icon: Icons.cloud_outlined,),
                PrayerColumn(waqt: "Maghrib", waqtPrayerTime: pTimes.maghrib, icon: Icons.wb_cloudy_rounded,),
                PrayerColumn(waqt: "Isha", waqtPrayerTime: pTimes.isha, icon: Icons.wb_sunny,),
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