import 'dart:io';
import 'dart:async';
import 'package:almuslim/models/surahs.dart';
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

  Future<List<Surah>> getAllSurahs() async{
    final db = await database;
    var res = await db.query('surahs');
    List<Surah> list = res.isNotEmpty ? res.map((e) => Surah.fromMap(e)).toList() : [];
    return list;
  }

  void dispose() {
    _database?.close();
    _database = null;
  }

  Future<Database> _initialize() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "db/quran_basic.db");
    Database db = await openDatabase(
      path,
      version: 1,
      onOpen: (db){
        print('opened Database');
      }
    );
  }
}
