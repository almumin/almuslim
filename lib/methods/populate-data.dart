import 'dart:convert';
import 'dart:io';

import '../database/store.dart';
import '../models/constants.dart';
import '../models/quran-entity.dart';
import 'package:almuslim/objectbox.g.dart' as ob;
import 'package:hive/hive.dart';

class InitializeApp {
  final Box hiveStore;
  final ob.Box<QuranAyah> objectBoxStore;

  InitializeApp(this.hiveStore, this.objectBoxStore);

  void PopulateQuranData() async{
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
          this.hiveStore.put("migration", "ongoing");
          this.objectBoxStore.removeAll();
          print("Started migration");
        }
        if (count <= TotalAyah) {
          var quranLine = line.split('|');
          var quran = new QuranAyah();
          quran.id = count;
          quran.surahNumber = int.parse(quranLine[0]);
          quran.ayahNumber = int.parse(quranLine[1]);
          quran.text = quranLine[2];
          this.objectBoxStore.put(quran);
          count++;
        }
        if (count == TotalAyah) {
          print("Ended migration. With ${count} lines");
        }
      },
    ).onDone(() {
      print("Migration done");
      this.PopulateQuranEnglishTranslationData();
    }));
  }

  void PopulateQuranEnglishTranslationData() async{
    var count = 1;
    new HttpClient()
        .getUrl(Uri.parse(
        'https://tanzil.net/trans/?transID=en.ahmedali&type=txt'))
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
          QuranAyah quranAyah = objectBoxStore.get(count);
          quranAyah.englishText = line;
          this.objectBoxStore.put(quranAyah);
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

