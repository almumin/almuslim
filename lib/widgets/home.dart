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
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  "${_hijriToday.hDay} ${_hijriToday.longMonthName} ${_hijriToday.hYear}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.icecream,
                    size: 100,
                    color: Colors.black,
                  ),
                ),
                Container(
                  color: Colors.grey.shade300,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 100,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
