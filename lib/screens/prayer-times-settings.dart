import 'package:adhan/adhan.dart';
import 'package:almuslim/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/calculation-methods.dart';

class PrayerTimesSettings extends StatefulWidget {
  final Box box;
  const PrayerTimesSettings({Key key, this.box}) : super(key: key);

  @override
  State<PrayerTimesSettings> createState() => _PrayerTimesSettingsState();
}

class _PrayerTimesSettingsState extends State<PrayerTimesSettings> {
  List<CalculationModel> calculationMethods = [];

  @override
  void initState() {
    super.initState();
    String currentCalculationMethod = widget.box.get("calculationMethod");
    List<CalculationMethods> allCalculationMethods =
        CalculationMethods.getMethods();
    for (int i = 0; i < allCalculationMethods.length; i++) {
      bool selected = false;
      if (currentCalculationMethod != null &&
          currentCalculationMethod == allCalculationMethods[i].id) {
        selected = true;
      }
      calculationMethods.add(new CalculationModel(
          selected,
          allCalculationMethods[i].id,
          allCalculationMethods[i].name,
          allCalculationMethods[i].description));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer times settings"),
        backgroundColor: baseGreenColor,
      ),
      body: new ListView.builder(
        itemCount: calculationMethods.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            highlightColor: baseGreenColor,
            splashColor: baseGreenColor,
            onTap: () {
              setState(() {
                calculationMethods
                    .forEach((element) => element.isSelected = false);
                calculationMethods[index].isSelected = true;
              });
              widget.box.put("calculationMethod", calculationMethods[index].id);
            },
            child: new CalculationRadioItem(calculationMethods[index]),
          );
        },
      ),
    );
  }
}

class CalculationModel {
  bool isSelected;
  final String id;
  final String name;
  final String description;

  CalculationModel(this.isSelected, this.id, this.name, this.description);
}

class CalculationRadioItem extends StatelessWidget {
  final CalculationModel _item;
  CalculationRadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          InkWell(
            child: new Container(
              height: 20.0,
              width: 20.0,
              child: new Center(
                child: new Text("",
                    style: new TextStyle(
                        color: _item.isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              ),
              decoration: new BoxDecoration(
                color: _item.isSelected ? baseGreenColor : Colors.transparent,
                border: new Border.all(
                    width: 1.0,
                    color: _item.isSelected ? baseGreenColor : Colors.grey),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(2.0)),
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_item.name),
                  SizedBox(height: 5),
                  Text(
                    _item.description,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
