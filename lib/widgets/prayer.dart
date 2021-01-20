import 'package:flutter/material.dart';

class PrayerColumn extends StatelessWidget {
  final String waqt;
  final DateTime waqtPrayerTime;
  final IconData icon;

  const PrayerColumn({Key key, this.waqt, this.waqtPrayerTime, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(width: 15,),
            Icon(
              icon
            ),
            SizedBox(width: 15,),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                waqt,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                waqtPrayerTime.hour.toString() + ":"+ waqtPrayerTime.minute.toString().padLeft(2, "0"),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerHeading extends StatelessWidget {
  final String headingTitle;
  const PrayerHeading({
    Key key,
    this.headingTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        color: Colors.grey.shade200,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 21,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    headingTitle,
                    style: TextStyle(color: Colors.green, fontSize: 21),
                  ),
                ],
              )
          ),
      ),
    );
  }
}

