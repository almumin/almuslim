import 'dart:io';
import 'dart:async';
import 'package:almuslim/models/ayah-with-translation.dart';
import 'package:almuslim/models/ayah.dart';
import 'package:almuslim/models/names-of-Allah.dart';
import 'package:almuslim/models/surahs.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  Database _database;

  Future<Database> get database async{
    if (_database == null){
      _database = await _initialize();
    }
    return _database;
  }

  Future<List<Surah>> getAllSurahs() async {
    final db = await database;
    var res = await db.query('surahs');
    List<Surah> list =
        res.isNotEmpty ? res.map((e) => Surah.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Ayah>> getAyahsForSurah(int surahID) async {
    final db = await database;
    var res =
        await db.rawQuery('SELECT * FROM quran_text WHERE sura=?', [surahID]);
    List<Ayah> list =
        res.isNotEmpty ? res.map((e) => Ayah.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Ayah>> getAyahByIndex(int index) async {
    final db = await database;
    var res =
        await db.rawQuery('SELECT * FROM quran_text WHERE index=?', [index]);
    List<Ayah> list =
        res.isNotEmpty ? res.map((e) => Ayah.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<NamesOfAllah>> get99NamesOfAllah() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM namesOfAllah');
    List<NamesOfAllah> list =
        res.isNotEmpty ? res.map((e) => NamesOfAllah.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<AyahWithTranslationAndTransliteration>>
      getAyahsWithTranslationAndTransliterationForSurah(int surahID) async {
    final db = await database;
    var res = await db.rawQuery(
        'SELECT quran_arabic.[index], quran_arabic.sura, quran_arabic.aya, quran_arabic.text, '
        'en_transliteration.text as transliteration, en_sahih.text as translation '
        'FROM quran_text AS quran_arabic'
        ' INNER JOIN en_transliteration ON en_transliteration.[index]=quran_arabic.[index] '
        ' INNER JOIN en_sahih ON en_sahih.[index]=quran_arabic.[index] '
        ' WHERE quran_arabic.sura=?',
        [surahID]);
    List<AyahWithTranslationAndTransliteration> list = res.isNotEmpty
        ? res
            .map((e) => AyahWithTranslationAndTransliteration.fromMap(e))
            .toList()
        : [];
    return list;
  }

  void dispose() {
    _database?.close();
    _database = null;
  }

  Future<Database> _initialize() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "working_data.db");

    ByteData data = await rootBundle.load(join("db", "quran_basic.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);

    Database db = await openDatabase(
      path,
      version: 1,
      onOpen: (db){
        print('opened Database');
      }
    );

    return db;
  }
}
