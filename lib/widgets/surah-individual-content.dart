import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/ayah-with-translation.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../database/store.dart';
import '../models/quran-entity.dart';
import '../modules/constants.dart';
import '../objectbox.g.dart' as ob;

class SurahIndividualWithAyahs extends StatelessWidget {
  final Surah surahInfo;
  final Box box;
  final ObjectBox objectBox;

  SurahIndividualWithAyahs({Key key, this.surahInfo, this.box, this.objectBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = this.box.get('theme');

    var userBox = this.objectBox.store.box<QuranAyah>();
    final query =
        (userBox.query(ob.QuranAyah_.surahNumber.equals(this.surahInfo.id))
              ..order(ob.QuranAyah_.id))
            .build();
    final results = query.find();
    print(results.length);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: results.length,
        physics: ClampingScrollPhysics(),
        itemBuilder: (_, int index) {
          var ayah = results[index];
          return InkWell(
            onTap: () => {print(surahInfo.latin)},
            child: ListTile(
              title: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ))),
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${ayah.text}",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: themeSet[theme]["textColor"],
                          ),
                        ),
                      ),
                      /*Text(
                            "${ayah.transliteration}",
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),*/
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${ayah.ayahNumber}. ${ayah.englishText}",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            color: themeSet[theme]["textColor"],
                          ),
                        ),
                      ),
                      Container(
                        color: themeSet[theme]["backgroundColor"],
                        child: SizedBox(
                          height: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
