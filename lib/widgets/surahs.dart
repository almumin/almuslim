import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:almuslim/screens/surah-individual.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../modules/constants.dart';

class SurahList extends StatelessWidget {
  final Box box;

  const SurahList({Key key, this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DBProvider>(context);
    var theme = this.box.get('theme');
    return FutureBuilder<List<Surah>>(
      future: dbProvider.getAllSurahs(),
      builder: (_, AsyncSnapshot<List<Surah>> snapshot) {
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
        var surahs = snapshot.data;
        if (surahs.length == 0) {
          return Center(
            child: Text("No data"),
          );
        }

        return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (_, int index) {
              var surah = surahs[index];
              return Container(
                color: themeSet[theme]["backgroundColor"],
                child: InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SurahIndividual(
                                  surah: surahs[index],
                                  box: this.box,
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
                          "${surah.english} (${surah.numberOfAyah.toString()})",
                          style: TextStyle(
                              fontSize: 11,
                              color: themeSet[theme]["textColor"]),
                        ),
                      ],
                    ),
                    trailing: Text(
                      surah.arabic,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade500,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
