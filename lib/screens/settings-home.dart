import 'dart:collection';

import 'package:almuslim/modules/constants.dart';
import 'package:almuslim/screens/prayer-times-settings.dart';
import 'package:almuslim/widgets/alert-with-data-radiobutton.dart';
import 'package:flutter/material.dart';
import 'package:almuslim/widgets/settings-title.dart';
import 'package:hive/hive.dart';

class SettingsHome extends StatefulWidget {
  final Box box;

  const SettingsHome({Key key, this.box}) : super(key: key);

  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    var theme = widget.box.get('theme');
    return Scaffold(
        bottomNavigationBar: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                Text(
                  "Go back",
                  style: TextStyle(
                    color: themeSet[theme]["textColor"],
                  ),
                ),
              ],
            ),
          ),
          onTap: () => {Navigator.of(context).pop()},
        ),
        body: Container(
          color: themeSet[theme]["backgroundColor"],
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: themeSet[theme]["baseColor"],
                  image: DecorationImage(
                    image: AssetImage("assets/icons/masjid-short.png"),
                    alignment: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        " Settings ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 4, top: 20, left: 30, right: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //color: Colors.white30,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SettingsTitle(
                                icon: Icons.access_time_outlined,
                                headingText: "Prayer Times",
                                hasBorder: true,
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrayerTimesSettings(
                                                box: widget.box,
                                              )))
                                },
                              ),
                              SettingsTitle(
                                icon: Icons.book,
                                headingText: "Quran",
                                hasBorder: true,
                              ),
                              SettingsTitle(
                                icon: Icons.fiber_manual_record_outlined,
                                headingText: "Duas",
                                hasBorder: true,
                              ),
                              SettingsTitle(
                                icon: Icons.calendar_today,
                                headingText: "Calendar",
                                hasBorder: true,
                              ),
                              SettingsTitle(
                                icon: Icons.language,
                                headingText: "Languages",
                                hasBorder: true,
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertRadioButtonWithData(
                                    title: "Set language",
                                    data: {
                                      'english': "English",
                                      'turkish': "Turkish",
                                      'bengali': "Bengali",
                                      'urdu': "Urdu"
                                    },
                                    box: widget.box,
                                    dataKey: "language",
                                  ),
                                ),
                              ),
                              SettingsTitle(
                                icon: Icons.design_services,
                                headingText: "Themes",
                                hasBorder: false,
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertRadioButtonWithData(
                                    title: "Set theme",
                                    data: {
                                      'lightTheme': "Light",
                                      'darkTheme': "Dark"
                                    },
                                    box: widget.box,
                                    dataKey: "theme",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
