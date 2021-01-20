import 'package:flutter/material.dart';

class PrayerColumn extends StatelessWidget {
  final String waqt;
  final DateTime waqtPrayerTime;
  final IconData icon;

  const PrayerColumn({Key key, this.waqt, this.waqtPrayerTime, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(icon),
            SizedBox(
              width: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                waqt,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                waqtPrayerTime.hour.toString() +
                    ":" +
                    waqtPrayerTime.minute.toString().padLeft(2, "0"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/015-mosque.png"),
              alignment: Alignment.centerRight,
            ),
            color: Color(0XFF50bb64),
            borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "20:31",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    "Tampere, Finland",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
