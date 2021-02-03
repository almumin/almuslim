import 'package:flutter/material.dart';
import 'package:almuslim/widgets/settings-title.dart';

class SettingsHome extends StatefulWidget {
  @override
  _SettingsHomeState createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.settings),
              Text(" Settings"),
            ],
          ),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 4, top: 20, left: 20, right: 20),
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
                            ),
                            SettingsTitle(
                              icon: Icons.design_services,
                              headingText: "Themes",
                              hasBorder: false,
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
        ));
  }
}
