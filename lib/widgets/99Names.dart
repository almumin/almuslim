import 'package:almuslim/data/quran.dart';
import 'package:almuslim/models/names-of-Allah.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamesOfAllahList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DBProvider>(context);
    return FutureBuilder<List<NamesOfAllah>>(
        future: dbProvider.get99NamesOfAllah(),
        builder: (_, AsyncSnapshot<List<NamesOfAllah>> snapshot) {
          print("99names snapshot.error.toString()");
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

          var names = snapshot.data;
          if (names.length == 0) {
            return Center(
              child: Text("No data"),
            );
          }

          return ListView.builder(
              itemCount: names.length,
              itemBuilder: (_, int index) {
                var name = names[index];
                return InkWell(
                  onTap: () => {},
                  child: ListTile(
                    leading: Text("${name.id}."),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name.transliteration,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          name.meaning,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    trailing: Text(name.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                      ),),
                  ),
                );
              });
        });
  }
}
