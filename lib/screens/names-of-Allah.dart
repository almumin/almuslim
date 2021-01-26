import 'package:almuslim/data/quran.dart';
import 'package:almuslim/widgets/99Names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamesOfAllah extends StatefulWidget {
  @override
  _NamesOfAllahState createState() => _NamesOfAllahState();
}

class _NamesOfAllahState extends State<NamesOfAllah> {
  @override
  Widget build(BuildContext context) {
    return Provider<DBProvider>(
      create: (_) => DBProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("99 names of Allah"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: Container(
            child: NamesOfAllahList(),
        ),
      ),
    );
  }
}
