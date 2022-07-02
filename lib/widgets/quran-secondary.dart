import 'package:almuslim/database/store.dart' as ob;
import 'package:almuslim/objectbox.g.dart';
import 'package:flutter/material.dart';

import '../models/app-context-hive.dart';
import '../models/quran-entity.dart';
import '../modules/constants.dart';
import '../screens/surah-individual.dart';

class QuranSecondary extends StatefulWidget {
  final ob.ObjectBox objectBox;

  const QuranSecondary({Key key, this.objectBox}) : super(key: key);

  @override
  State<QuranSecondary> createState() => _QuranSecondaryState();
}

class _QuranSecondaryState extends State<QuranSecondary> {
  List<QuranAyah> results;
  List<Surahs> surahs;
  @override
  void initState() {
    Box quranObjectBox = widget.objectBox.store.box<QuranAyah>();
    Box surahObjectBox = widget.objectBox.store.box<Surahs>();
    final query = (quranObjectBox.query(QuranAyah_.isFavorite.equals(true))
          ..order(QuranAyah_.id))
        .build();

    results = query.find();
    surahs = surahObjectBox.getAll();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: results.length,
        itemBuilder: (_, int index) {
          var surahNumber = results[index].surahNumber - 1;
          return Container(
              // color: themeSet[theme]["backgroundColor"],
              child: InkWell(
            onTap: () => {},
            child: ListTile(
              leading: Text(
                "${surahs[surahNumber].id}.",
                style: TextStyle(
                  color: /*themeSet[theme]["textColor"]*/ Colors.green,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    surahs[surahNumber].latin,
                    style: TextStyle(
                      fontSize: 15,
                      color: /*themeSet[theme]["textColor"]*/ Colors.black,
                    ),
                  ),
                  Text(
                    "${surahs[surahNumber].id}:${results[index].ayahNumber.toString()}",
                    style: TextStyle(
                      fontSize: 11,
                      color: /*themeSet[theme]["textColor"])*/ Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
