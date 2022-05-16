import 'package:flutter/material.dart';

import '../database/store.dart';
import '../models/quran-entity.dart';
import '../objectbox.g.dart';

class DailyAyahByIndex extends StatefulWidget {
  final String index;
  final ObjectBox objectBox;

  const DailyAyahByIndex({Key key, this.index, this.objectBox}) : super(key: key);

  @override
  State<DailyAyahByIndex> createState() => _DailyAyahByIndexState();
}

class _DailyAyahByIndexState extends State<DailyAyahByIndex> {
  List<QuranAyah> results;
  List<Surahs> surahResult;

  @override
  void initState() {
    super.initState();
    var quranBox = widget.objectBox.store.box<QuranAyah>();
    var query =
    (quranBox.query(QuranAyah_.id.equals(int.parse(widget.index)))).build();
    results = query.find();
    var surahBox = widget.objectBox.store.box<Surahs>();
    var findSurahQuery =
    (surahBox.query(Surahs_.id.equals(results[0].surahNumber))).build();
    surahResult = findSurahQuery.find();
  }

  @override
  Widget build(BuildContext context) {
    if (results.length == 0 || surahResult.length == 0) {
      return Center(
        child: Text("No data"),
      );
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${results[0].arabicText}",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              softWrap: true,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${results[0].englishTranslation}",
              softWrap: true,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                    "Today's Ayah is from ${surahResult[0].latin}: ${results[0].surahNumber}:${results[0].ayahNumber}"),
                InkWell(
                  child: Icon(Icons.read_more),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
