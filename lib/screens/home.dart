import 'dart:async';

import 'package:almuslim/methods/populate-data.dart';
import 'package:almuslim/screens/names-of-Allah.dart';
import 'package:almuslim/screens/prayer.dart';
import 'package:almuslim/screens/quran.dart';
import 'package:almuslim/screens/reminders.dart';
import 'package:almuslim/screens/settings-home.dart';
import 'package:almuslim/widgets/home-heading-with-content.dart';
import 'package:almuslim/widgets/home-icon.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive/hive.dart';
import 'package:almuslim/widgets/daily-ayah.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';

import '../database/store.dart';
import '../modules/constants.dart';

class HomeView extends StatefulWidget {
  final Box box;
  final LocationData locationData;
  final List<Placemark> placemarks;
  final ObjectBox objectBox;

  HomeView(
      {Key key,
      @required this.box,
      this.locationData,
      this.placemarks,
      this.objectBox})
      : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime today;
  Timer _everySecond;

  // AppContext appContext = new AppContext(language, theme);
  @override
  void initState() {
    super.initState();
    print("Migration status: " + widget.box.get("migration"));
    InitializeApp init = new InitializeApp(widget.box, widget.objectBox);
    // widget.box.put("migration", "a");
    if (widget.box.get("migration") != "done" && widget.box.get("migration") != "ongoing") {
      init.PopulateQuranData(context);
    }
    // sets first datetime value
    today = DateTime.now();
    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        today = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var ayah = widget.box.get('dailyAyah');



    HijriCalendar _hijriToday = new HijriCalendar.now();
    if (today == null) {
      today = DateTime.now();
    }
    var theme = widget.box.get('theme');
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
          backgroundColor: themeSet[theme]["backgroundColor"],
          leading: InkWell(
            child: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsHome(
                            box: widget.box,
                          )))
            },
          ),
        ),
        backgroundColor: themeSet[theme]["backgroundColor"],
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
                      "${widget.placemarks.last.street}, ${widget.placemarks.last.locality}"),
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
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Prayer(
                                      locationData: widget.locationData,
                                      placemarks: widget.placemarks,
                                      box: widget.box,
                                    )))
                      },
                    ),
                    HomeIcon(
                      iconPath: "005-Quran.png",
                      text: "Quran",
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuranHome(
                                      box: widget.box,
                                      objectBox: widget.objectBox,
                                    )))
                      },
                    ),
                    HomeIcon(
                      iconPath: "001-allah.png",
                      text: "99 names",
                      textColor: themeSet[theme]["textColor"],
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
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsHome(
                                      box: widget.box,
                                    )))
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    HomeIcon(
                      iconPath: "003-candle.png",
                      text: "Hadith",
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "halal-sign.png",
                      text: "Halal",
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "dua-hands.png",
                      text: "Duas",
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "023-date-palm.png",
                      text: "Reminder",
                      textColor: themeSet[theme]["textColor"],
                      onTapRun: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reminders()))
                      },
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
                objectBox: widget.objectBox,
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
