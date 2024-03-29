import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';

import '../database/store.dart';
import '../models/quran-entity.dart';
import '../modules/constants.dart';
import '../objectbox.g.dart' as ob;
import 'ayah-options.dart';

class SurahIndividualWithAyahs extends StatelessWidget {
  final Surahs surahInfo;
  final Box box;
  final ObjectBox objectBox;

  SurahIndividualWithAyahs({Key key, this.surahInfo, this.box, this.objectBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = this.box.get('theme');
    var quranObjectBox = this.objectBox.store.box<QuranAyah>();
    final query = (quranObjectBox
            .query(ob.QuranAyah_.surahNumber.equals(this.surahInfo.id))
          ..order(ob.QuranAyah_.id))
        .build();
    final results = query.find();

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
                      Html(
                        data: "${ayah.arabicText}",
                        style: {
                          "body": Style(
                            fontSize: FontSize(30),
                            fontWeight: FontWeight.w500,
                            alignment: Alignment.center,
                            textAlign: TextAlign.right,
                            direction: TextDirection.rtl,
                          ),
                        },
                      ),
                      Html(
                        data: "${ayah.transliteration}",
                        style: {
                          "body": Style(
                            fontSize: FontSize(16),
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                          ),
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${ayah.ayahNumber}. ${ayah.englishTranslation}",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            color: themeSet[theme]["textColor"],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            AyahOptions(
                              icon: Icons.check_circle,
                              selectionColor: Colors.green,
                              objectBox: this.objectBox,
                              id: ayah.id,
                              optionType: "readAlready",
                              isSelected: ayah.readAlready != null
                                  ? ayah.readAlready
                                  : false,
                            ),
                            AyahOptions(
                              icon: Icons.favorite,
                              selectionColor: Colors.red,
                              objectBox: this.objectBox,
                              id: ayah.id,
                              optionType: "favorite",
                              isSelected: ayah.isFavorite != null
                                  ? ayah.isFavorite
                                  : false,
                            ),
                          ],
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
