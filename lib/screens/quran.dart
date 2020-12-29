import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuranHome extends StatefulWidget {
  @override
  _QuranHomeState createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quran"),
        backgroundColor: Colors.blueGrey.shade900,
        bottom: new TabBar(controller: controller, tabs: [
          new Tab(
            icon: new Icon(Icons.menu_book_outlined),
          ),
          new Tab(
            icon: new Icon(Icons.remove_red_eye_outlined),
          ),
        ]),
      ),
      body: new TabBarView(controller: controller, children: [
        Text("Quran Home"),
        Text("Quran Secondary"),
      ]),
    );
  }
}
