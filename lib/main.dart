import 'dart:io';
import 'package:adhan/adhan.dart';
import 'package:almuslim/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';
import 'package:almuslim/data/quran.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  var box = await Hive.openBox("almuslim");
  box.put('dailyAyah', '283');

  runApp(new MaterialApp(
    home: Provider<DBProvider>(
      create: (_) => DBProvider(),
      child: HomeView(
        box: box,
      ),
    ),
  ));
}
