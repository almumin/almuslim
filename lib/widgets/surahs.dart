import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurahList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DBProvider>(context);
    return FutureBuilder<List<Surah>>(
      future: dbProvider.getAllSurahs(),
      builder: (_, AsyncSnapshot<List<Surah>> snapshot) {
        print(snapshot.hasData);
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
              return ListTile(
                leading: Text(surah.id.toString()),
                title: Text(surah.english),
                trailing: Text(surah.numberOfAyah.toString()),
              );
            });
      },
    );
  }
}
