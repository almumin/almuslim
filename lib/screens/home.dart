import 'package:almuslim/screens/names-of-Allah.dart';
import 'package:almuslim/screens/prayer.dart';
import 'package:almuslim/screens/quran.dart';
import 'package:almuslim/screens/settings-home.dart';
import 'package:almuslim/widgets/home-heading-with-content.dart';
import 'package:almuslim/widgets/home-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:almuslim/data/quran.dart';
import 'package:almuslim/widgets/daily-ayah.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';

class HomeView extends StatelessWidget {
  final Box box;
  final LocationData locationData;
  final List<Placemark> placemarks;

  HomeView({Key key, @required this.box, this.locationData, this.placemarks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HijriCalendar _hijriToday = new HijriCalendar.now();
    DateTime today = DateTime.now();
    var ayah = box.get('dailyAyah');
    var dbProvider = Provider.of<DBProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "${today.day} ${today.month} ${today.year}",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.amber.shade900, fontSize: 12),
                  ),
                  Text(
                    "${_hijriToday.hDay} ${_hijriToday.longMonthName} ${_hijriToday.hYear}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          /*leading: InkWell(
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            onTap: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsHome())) },
          ),*/
        ),
        backgroundColor: Colors.grey.shade100,
        body: ListView(children: [
          Stack(children: [
            Container(
              child: Image.asset(
                "assets/images/Illustration07.jpg",
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 60,
              child: Text(
                today.hour.toString().padLeft(2, "0") +
                    ":" +
                    today.minute.toString().padLeft(2, "0"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 16,
                  ),
                  Text(
                      "${placemarks.last.street}, ${placemarks.last.locality}"),
                ],
              ),
              top: 10,
              left: 10,
            ),
          ]),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    HomeIcon(
                      iconPath: "013-prayer-mat.png",
                      text: "Prayer",
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Prayer(
                                  locationData: locationData,
                                  placemarks: placemarks,
                                )))
                      },
                    ),
                    HomeIcon(
                      iconPath: "005-Quran.png",
                      text: "Quran",
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuranHome()))
                      },
                    ),
                    HomeIcon(
                      iconPath: "001-allah.png",
                      text: "99 names",
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NamesOfAllah()))
                      },
                    ),
                    HomeIcon(
                      iconPath: "settings.png",
                      text: "Settings",
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsHome()))
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    HomeIcon(
                      iconPath: "003-candle.png",
                      text: "Hadith",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "halal-sign.png",
                      text: "Halal",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "dua-hands.png",
                      text: "Duas",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "023-date-palm.png",
                      text: "Reminder",
                      onTapRun: () => {},
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          HomeHeadingWidget(
              headingTitle: "Daily Ayah",
              icon: Icons.menu_book,
              widgets: DailyAyahByIndex(
                index: ayah,
              )),
          HomeHeadingWidget(
            headingTitle: "Daily Hadith",
            widgets: Text("Some desc"),
          ),
          HomeHeadingWidget(
            headingTitle: "Daily Dua",
            widgets: Text("Some desc"),
          ),
          HomeHeadingWidget(
            headingTitle: "Daily Reminder",
            widgets: Text("Some desc"),
          ),
        ]));
  }
}
