import 'package:almuslim/screens/prayer.dart';
import 'package:almuslim/widgets/home-heading-with-content.dart';
import 'package:almuslim/widgets/home-icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class HomeView extends StatelessWidget {
  HijriCalendar _hijriToday = new HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Sunday, 27 December 2020",
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "8:31PM",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            )
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
                      iconPath: "praying-mat.png",
                      text: "Prayer",
                      onTapRun: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Prayer()))
                      },
                    ),
                    HomeIcon(
                      iconPath: "reading-quran.png",
                      text: "Quran",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "dua-hands.png",
                      text: "Duas",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "halal-sign.png",
                      text: "Halal",
                      onTapRun: () => {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    HomeIcon(
                      iconPath: "holy-quran.png",
                      text: "Hadith",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "qibla-compass.png",
                      text: "Qibla",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "arabic-art.png",
                      text: "Some other",
                      onTapRun: () => {},
                    ),
                    HomeIcon(
                      iconPath: "palm-tree-with-date.png",
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
          ),
          HomeHeadingWidget(
            headingTitle: "Daily Hadith",
          ),
          HomeHeadingWidget(
            headingTitle: "Daily Dua",
          ),
          HomeHeadingWidget(
            headingTitle: "Daily Reminder",
          ),
        ]));
  }
}
