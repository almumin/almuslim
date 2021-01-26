import 'package:meta/meta.dart';

class NamesOfAllah {

  final int id;
  final String name;
  final String transliteration;
  final String meaning;

  NamesOfAllah({@required this.id,@required this.name,@required this.transliteration,@required this.meaning});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'transliteration': transliteration,
    'meaning': meaning,
  };

  factory NamesOfAllah.fromMap(Map<String, dynamic> map) => NamesOfAllah(
    id: map["id"],
    name: map["name"],
    transliteration: map["transliteration"],
    meaning: map["meaning"],
  );
}