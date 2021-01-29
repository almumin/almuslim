import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:almuslim/screens/surah-individual.dart';
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
              return InkWell(
                onTap: () =>{
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SurahIndividual(surah: surahs[index],)))
                },
                child: ListTile(
                  leading: Text("${surah.id}."),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        surah.latin,
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                      Text(
                        "${surah.english} (${surah.numberOfAyah.toString()})",
                        style: TextStyle(fontSize: 11, color: Colors.black45),
                      ),
                    ],
                  ),
                  trailing: Text(
                    surah.arabic,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            });
      },
    );
  }
}
