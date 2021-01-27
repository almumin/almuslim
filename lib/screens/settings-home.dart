import 'package:flutter/material.dart';

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
            Icon(
              Icons.settings
            ),
            Text(
                " Settings"
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey.shade900,
      ),
    );
  }
}
