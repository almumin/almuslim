import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/ayah-with-translation.dart';
import 'package:almuslim/models/ayah.dart';
import 'package:almuslim/models/daily-ayah.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyAyahByIndex extends StatelessWidget {
  final String index;

  DailyAyahByIndex({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DBProvider>(context);
    return FutureBuilder<List<DailyAyahWithTranslationAndTransliteration>>(
      future: dbProvider.getAyahByIndex(int.parse(this.index)),
      builder: (_,
          AsyncSnapshot<List<DailyAyahWithTranslationAndTransliteration>>
              snapshot) {
        print(snapshot.error.toString());
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        var ayahs = snapshot.data;
        if (ayahs.length == 0) {
          return Center(
            child: Text("No data"),
          );
        }

        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${ayahs[0].text}",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                softWrap: true,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text(
                        "Today's Ayah is from ${ayahs[0].surahName}: ${ayahs[0].surah}:${ayahs[0].ayah}"),
                    InkWell(
                      child: Icon(Icons.read_more),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
