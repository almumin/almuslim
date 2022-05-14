import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../database/store.dart';
import '../models/constants.dart';
import '../models/quran-entity.dart';
import 'package:almuslim/objectbox.g.dart' as ob;
import 'package:hive/hive.dart';

class InitializeApp {
  final Box hiveStore;
  final ObjectBox objectBox;
  /*final ob.Box<QuranAyah> quranObjectBoxStore;
  final ob.Box<Surahs> surahObjectBoxStore;*/

  InitializeApp(this.hiveStore, this.objectBox/*, this.quranObjectBoxStore, this.surahObjectBoxStore*/);


  @override
  void initState() {


  }


  Future<String> loadFile(BuildContext context, String fileName) async {
    String jsonStringValues = await DefaultAssetBundle.of(context).loadString(fileName);
    return jsonStringValues;
  }

  void PopulateQuranData(BuildContext context) async{
    var surahObjectBox = objectBox.store.box<Surahs>();
    String jsonStringValues = await loadFile(context, "assets/data/surah.json");
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, dynamic> _localizedValues = mappedJson.map((key, value) => MapEntry(key, value));
    var count = 1;
    _localizedValues.forEach((key, value) {
      if (count == 1) {
        this.hiveStore.put("migration", "ongoing");
        surahObjectBox.removeAll();
        print("Started Surah migration");
      }
      if (count <= _localizedValues.length) {
        Surahs surah = Surahs(
          id: count,
          name: value["name"],
          ayah: value["nAyah"],
          revelationOrder: value["revelationOrder"],
          type: value["type"],
          startAyah: value["start"],
          endAyah: value["end"],
        );
        surahObjectBox.put(surah);
        count++;
      }
      if (count == _localizedValues.length) {
        print("Ended Surah data migration. With ${count} Surahs");
        this.PopulateQuranAyahData();
      }
    });
  }

  void PopulateQuranAyahData() async {
    var quranAyahObjectBox = objectBox.store.box<QuranAyah>();
    var count = 1;
    new HttpClient()
        .getUrl(Uri.parse(
            'https://tanzil.net/pub/download/index.php?marks=true&sajdah=true&tatweel=true&quranType=uthmani&outType=txt-2&agree=true'))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) => response
                .transform(new Utf8Decoder())
                .transform(new LineSplitter())
                .listen(
              (String line) {
                if (count == 1) {
                  quranAyahObjectBox.removeAll();
                  print("Started Quran basic migration");
                }
                if (count <= TotalAyah) {
                  var quranLine = line.split('|');
                  var quran = new QuranAyah();
                  quran.id = count;
                  quran.surahNumber = int.parse(quranLine[0]);
                  quran.ayahNumber = int.parse(quranLine[1]);
                  quran.text = quranLine[2];
                  quranAyahObjectBox.put(quran);
                  count++;
                }
                if (count == TotalAyah) {
                  print("Ended Quran basic migration. With ${count} lines");
                }
              },
            ).onDone(() {
              print("Quran basic Migration done");
              this.PopulateQuranEnglishTranslationData();
            }));
  }

  void PopulateQuranEnglishTranslationData() async {
    var quranAyahObjectBox = objectBox.store.box<QuranAyah>();
    var count = 1;
    new HttpClient()
        .getUrl(
            Uri.parse('https://tanzil.net/trans/?transID=en.ahmedali&type=txt'))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) => response
                .transform(new Utf8Decoder())
                .transform(new LineSplitter())
                .listen(
              (String line) {
                if (count == 1) {
                  this.hiveStore.put("migration", "ongoing");
                  print("Started translation migration");
                }
                if (count <= TotalAyah) {
                  QuranAyah quranAyah = quranAyahObjectBox.get(count);
                  quranAyah.englishText = line;
                  quranAyahObjectBox.put(quranAyah);
                  count++;
                }
                if (count == TotalAyah) {
                  print("Ended translation migration. With ${count} lines");
                }
              },
            ).onDone(() {
              print("Migration for translation done");
              this.hiveStore.put("migration", "done");
            }));
  }
}
