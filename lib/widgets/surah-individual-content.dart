import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/ayah-with-translation.dart';
import 'package:almuslim/models/ayah.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahIndividualWithAyahs extends StatelessWidget {
  final Surah surahInfo;

  SurahIndividualWithAyahs({Key key, this.surahInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DBProvider>(context);
    return FutureBuilder<List<AyahWithTranslationAndTransliteration>>(
      //future: dbProvider.getAyahsForSurah(this.surahInfo.id),
      future: dbProvider
          .getAyahsWithTranslationAndTransliterationForSurah(this.surahInfo.id),
      builder: (_,
          AsyncSnapshot<List<AyahWithTranslationAndTransliteration>> snapshot) {
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

        return ListView.builder(
            shrinkWrap: true,
            itemCount: ayahs.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (_, int index) {
              var ayah = ayahs[index];
              return InkWell(
                onTap: () => {print(surahInfo.latin)},
                child: ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1,
                              color: Colors.grey
                    ))),
                    child: Column(
                      children: [
                        Text(
                          "${ayah.text}",
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        /*Text(
                          "${ayah.transliteration}",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),*/
                        Text(
                          "${ayah.ayah}. ${ayah.translation}",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
