import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  final IconData icon;
  final String headingText;
  final bool hasBorder;

  const SettingsTitle({Key key, this.icon, this.headingText, this.hasBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12, left: 12, right: 12),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.black38,
            width: 1.0,
          ),
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 17,
                color: Colors.black54,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                headingText,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
