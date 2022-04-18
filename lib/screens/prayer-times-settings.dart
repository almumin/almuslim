import 'package:almuslim/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PrayerTimesSettings extends StatefulWidget {
  final Box box;
  const PrayerTimesSettings({Key key, this.box}) : super(key: key);

  @override
  State<PrayerTimesSettings> createState() => _PrayerTimesSettingsState();
}

class _PrayerTimesSettingsState extends State<PrayerTimesSettings> {

  List<CalculationModel> calculationMethods = new List<CalculationModel>();

  @override
  void initState() {
    super.initState();
    calculationMethods.add(new CalculationModel(true, 'muslim_world_league', 'Muslim world league'));
    calculationMethods.add(new CalculationModel(false, 'egyptian', 'Egyptian'));
    calculationMethods.add(new CalculationModel(false, 'karachi', 'Karachi'));
    calculationMethods.add(new CalculationModel(false, 'umm_al_qura', 'Umm Al Qura'));
    calculationMethods.add(new CalculationModel(false, 'dubai', 'Dubai'));
    calculationMethods.add(new CalculationModel(false, 'qatar', 'Qatar'));
    calculationMethods.add(new CalculationModel(false, 'kuwait', 'Kuwait'));
    calculationMethods.add(new CalculationModel(false, 'singapore', 'Singapore'));
    calculationMethods.add(new CalculationModel(false, 'north_america', 'North america'));
  }

  @override
  Widget build(BuildContext context) {
    var method = widget.box.get('calculationMethod');
    print(method);
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer times settings"),
        backgroundColor: baseGreenColor,
      ),
      body: new ListView.builder(
        itemCount: calculationMethods.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                calculationMethods.forEach((element) => element.isSelected = false);
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

  CalculationModel(this.isSelected, this.id, this.name);
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
                borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.name),
          )
        ],
      ),
    );
  }
}
