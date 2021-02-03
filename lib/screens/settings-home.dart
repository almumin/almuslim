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
        body: ListView(
          children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xFF87D7F5),
              image: DecorationImage(
                image: AssetImage("assets/icons/istanbul.png"),
                alignment: Alignment.centerRight,
              )),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.black54,
                ),
                Text(
                  " Settings ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 4, top: 20, left: 30, right: 30),
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
