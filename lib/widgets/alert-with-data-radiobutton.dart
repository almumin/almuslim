import 'package:almuslim/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AlertRadioButtonWithData extends StatefulWidget {
  final String title;
  final Map<String, String> data;
  final Box box;
  final String dataKey;
  const AlertRadioButtonWithData(
      {Key key, this.title, this.data, this.box, this.dataKey})
      : super(key: key);

  @override
  State<AlertRadioButtonWithData> createState() =>
      _AlertRadioButtonWithDataState();
}

class _AlertRadioButtonWithDataState extends State<AlertRadioButtonWithData> {
  String _currentValue;

  @override
  Widget build(BuildContext context) {
    _currentValue = widget.box.get(widget.dataKey);
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < widget.data.length; i++)
              RadioListTile<String>(
                title: Text(widget.data.values.elementAt(i)),
                value: widget.data.keys.elementAt(i),
                groupValue: _currentValue,
                selected: widget.data.keys.elementAt(i) == _currentValue
                    ? true
                    : false,
                activeColor: baseGreenColor,
                onChanged: (String value) {
                  setState(() {
                    _currentValue = value;
                    widget.box.put(widget.dataKey, _currentValue);
                  });
                },
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            'Cancel',
            style: TextStyle(color: baseGreenColor),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            'OK',
            style: TextStyle(color: baseGreenColor),
          ),
        ),
      ],
    );
  }
}
