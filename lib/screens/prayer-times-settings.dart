import 'package:adhan/adhan.dart';
import 'package:almuslim/modules/constants.dart';
import 'package:almuslim/widgets/calculation_methods.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/calculation-methods.dart';
import '../widgets/alert-with-data-radiobutton.dart';
import '../widgets/settings-title.dart';

class PrayerTimesSettings extends StatefulWidget {
  final Box box;
  const PrayerTimesSettings({Key key, this.box}) : super(key: key);

  @override
  State<PrayerTimesSettings> createState() => _PrayerTimesSettingsState();
}

class _PrayerTimesSettingsState extends State<PrayerTimesSettings> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer times settings"),
        backgroundColor: baseGreenColor,
      ),
      body: Container(child: Column(
        children: [
          CalculationMethodsWidget(box: widget.box),

          SettingsTitle(
            icon: Icons.language,
            headingText: "Madhab",
            hasBorder: true,
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AlertRadioButtonWithData(
                    title: "Set Madhab",
                    data: {
                      Madhab.shafi.toString(): "Shafi",
                      Madhab.hanafi.toString(): "Hanafi",
                    },
                    box: widget.box,
                    dataKey: "madhab",
                  ),
            ),
          )
        ],
      )),
    );
  }
}
