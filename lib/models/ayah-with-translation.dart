import 'package:meta/meta.dart';

class AyahWithTranslationAndTransliteration {

  final int index;
  final int surah;
  final int ayah;
  final String text;
  final String translation;
  final String transliteration;

  AyahWithTranslationAndTransliteration({@required this.index,@required this.surah,@required this.ayah,@required this.text, this.translation, this.transliteration});

  Map<String, dynamic> toMap() => {
    'index': index,
    'surah': surah,
    'aya': ayah,
    'text': text,
    'translation': translation,
    'transliteration': transliteration,
  };

  factory AyahWithTranslationAndTransliteration.fromMap(Map<String, dynamic> map) => AyahWithTranslationAndTransliteration(
    index: map["index"],
    surah: map["surah"],
    ayah: map["aya"],
    text: map["text"],
    translation: map["translation"],
    transliteration: map["transliteration"],
  );
}