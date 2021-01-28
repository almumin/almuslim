import 'package:meta/meta.dart';

class Ayah {

  final int index;
  final int surah;
  final int ayah;
  final String text;

  Ayah({@required this.index,@required this.surah,@required this.ayah,@required this.text});

  Map<String, dynamic> toMap() => {
        'index': index,
        'sura': surah,
        'aya': ayah,
        'text': text,
      };

  factory Ayah.fromMap(Map<String, dynamic> map) => Ayah(
        index: map["index"],
        surah: map["sura"],
        ayah: map["aya"],
        text: map["text"],
      );
}