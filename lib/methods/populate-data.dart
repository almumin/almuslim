import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../database/store.dart';
import '../models/constants.dart';
import '../models/quran-entity.dart';
import 'package:hive/hive.dart';

class InitializeApp {
  final Box hiveStore;
  final ObjectBox objectBox;

  InitializeApp(this.hiveStore, this.objectBox);

  Future<String> loadFile(BuildContext context, String fileName) async {
    String jsonStringValues = await DefaultAssetBundle.of(context).loadString(fileName);
    return jsonStringValues;
  }

  void PopulateQuranData(BuildContext context) async{
    var surahObjectBox = objectBox.store.box<Surahs>();
    String jsonStringValues = await loadFile(context, "assets/data/surahs.json");
    List<dynamic> mappedJson = jsonDecode(jsonStringValues);

    var count = 1;
    mappedJson.forEach((value) {
      if (count == 1) {
        this.hiveStore.put("migration", "ongoing");
        print("Started Surah migration");
      }
      if (count <= mappedJson.length) {
        Surahs surah = Surahs(
          id: value["id"],
          arabic: value["arabic"],
          arabicShort: value["arabicShort"],
          english: value["english"],
          latin: value["latin"],
          ayah: value["ayah"],
          revelationOrder: int.parse(value["revelationOrder"]),
          location: value["location"],
          type: value["type"],
          sajda: value["sajda"],
        );
        surahObjectBox.put(surah);
        count++;
      }
      if (count == mappedJson.length) {
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
    print("quranAyahObjectBox");
    print(quranAyahObjectBox);
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
