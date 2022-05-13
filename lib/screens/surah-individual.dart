import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:almuslim/widgets/surah-individual-content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../database/store.dart';
import '../models/quran-entity.dart';
import '../modules/constants.dart';
import '../objectbox.g.dart' as ob;

class SurahIndividual extends StatefulWidget {
  final Surah surah;
  final Box box;
  final ObjectBox objectBox;

  const SurahIndividual(
      {Key key, @required this.surah, this.box, this.objectBox})
      : super(key: key);

  @override
  _SurahIndividualState createState() => _SurahIndividualState();
}

class _SurahIndividualState extends State<SurahIndividual> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var theme = widget.box.get('theme');

    return Provider<DBProvider>(
      create: (context) => DBProvider(),
      //dispose: (context, value) => value.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Surah",
            style: TextStyle(
              color: themeSet[theme]["textColor"],
            ),
          ),
          backgroundColor: themeSet[theme]["baseColor"],
        ),
        body: Container(
          color: themeSet[theme]["backgroundColor"],
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            controller: _controller,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0XFF50bb64),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          "${widget.surah.id}. ${widget.surah.latin}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${widget.surah.english}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Ayah: ${widget.surah.numberOfAyah}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SurahIndividualWithAyahs(
                  surahInfo: widget.surah, box: widget.box, objectBox: widget.objectBox,),
            ],
          ),
        ),
      ),
    );
  }
}
