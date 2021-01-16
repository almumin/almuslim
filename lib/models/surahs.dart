import 'package:meta/meta.dart';

class Surah {
  Surah(
      {@required this.id,
      @required this.arabic,
      @required this.latin,
      @required this.english,
      @required this.location,
      @required this.sajdah,
      @required this.numberOfAyah});

  final int id;
  final String arabic;
  final String latin;
  final String english;
  final int location;
  final int sajdah;
  final int numberOfAyah;

  Map<String, dynamic> toMap() => {
        'id': id,
        'arabic': arabic,
        'latin': latin,
        'english': english,
        'location': location,
        'sajdah': sajdah,
        'ayah': numberOfAyah,
      };

  factory Surah.fromMap(Map<String, dynamic> map) => Surah(
        id: map["id"],
        arabic: map["arabic"],
        latin: map["latin"],
        english: map["english"],
        location: map["location"],
        sajdah: map["sajdah"],
        numberOfAyah: map["ayah"],
      );
}
