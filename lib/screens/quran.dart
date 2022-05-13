import 'package:almuslim/data/quran.dart';
import 'package:almuslim/widgets/quran-secondary.dart';
import 'package:almuslim/widgets/surahs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../database/store.dart';
import '../modules/constants.dart';

class QuranHome extends StatefulWidget {
  final Box box;
  final ObjectBox objectBox;

  const QuranHome({Key key, this.box, this.objectBox}) : super(key: key);

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
    var theme = widget.box.get('theme');
    return Provider<DBProvider>(
      create: (_) => DBProvider(),
      //dispose: (_, value) => value.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quran"),
          backgroundColor: themeSet[theme]["secondaryBaseColor"],
          bottom: new TabBar(controller: controller, tabs: [
            new Tab(
              icon: new Icon(Icons.menu_book_outlined),
            ),
            new Tab(
              icon: new Icon(Icons.remove_red_eye_outlined),
            ),
          ]),
        ),
        body: new TabBarView(
            controller: controller,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              SurahList(box: widget.box, objectBox: widget.objectBox,),
              QuranSecondary(objectBox: widget.objectBox,),
            ]),
      ),
    );
  }
}
