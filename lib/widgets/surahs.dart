import 'package:almuslim/models/quran-entity.dart';
import 'package:almuslim/screens/surah-individual.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../database/store.dart';
import '../models/app-context-hive.dart';
import '../modules/constants.dart';

class SurahList extends StatelessWidget {
  final Box box;
  final ObjectBox objectBox;

  const SurahList({Key key, this.box, this.objectBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = ApplicationContext.fromJson(box.get('appContext')).theme;

    var surahBox = this.objectBox.store.box<Surahs>();
    final results = surahBox.getAll();

    if (results.length == 0) {
      return Center(
        child: Text("No data"),
      );
    }

    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (_, int index) {
          var surah = results[index];
          return Container(
            color: themeSet[theme]["backgroundColor"],
            child: InkWell(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SurahIndividual(
                          surah: results[index],
                          box: this.box,
                          objectBox: this.objectBox,
                        )))
              },
              child: ListTile(
                leading: Text(
                  "${surah.id}.",
                  style: TextStyle(
                    color: themeSet[theme]["textColor"],
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      surah.latin,
                      style: TextStyle(
                        fontSize: 15,
                        color: themeSet[theme]["textColor"],
                      ),
                    ),
                    Text(
                      "${surah.english} (${surah.ayah.toString()})",
                      style: TextStyle(
                          fontSize: 11,
                          color: themeSet[theme]["textColor"]),
                    ),
                  ],
                ),
                trailing: Text(
                  surah.arabicShort,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });
  }
}
