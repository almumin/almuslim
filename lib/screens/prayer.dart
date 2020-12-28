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
        title: Text("Prayer"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                PrayerHeading(headingTitle: "Prayer times",),
                PrayerColumn(waqt: "Fajr", waqtPrayerTime: pTimes.fajr,),
                PrayerColumn(waqt: "Duhr", waqtPrayerTime: pTimes.dhuhr,),
                PrayerColumn(waqt: "Asr", waqtPrayerTime: pTimes.asr,),
                PrayerColumn(waqt: "Maghrib", waqtPrayerTime: pTimes.maghrib,),
                PrayerColumn(waqt: "Isha", waqtPrayerTime: pTimes.isha,),
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