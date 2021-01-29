import 'package:meta/meta.dart';

class DailyAyahWithTranslationAndTransliteration {
  final int index;
  final int surah;
  final String surahName;
  final int ayah;
  final String text;
  final String translation;

  DailyAyahWithTranslationAndTransliteration(
      {@required this.index,
      @required this.surah,
      @required this.ayah,
      @required this.text,
      this.translation,
      this.surahName});

  Map<String, dynamic> toMap() => {
        'index': index,
        'sura': surah,
        'surah_name': surahName,
        'aya': ayah,
        'text': text,
        'translation': translation,
      };

  factory DailyAyahWithTranslationAndTransliteration.fromMap(
          Map<String, dynamic> map) =>
      DailyAyahWithTranslationAndTransliteration(
        index: map["index"],
        surah: map["sura"],
        surahName: map["surah_name"],
        ayah: map["aya"],
        text: map["text"],
        translation: map["translation"],
      );
}
