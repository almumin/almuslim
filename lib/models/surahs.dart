import 'package:meta/meta.dart';

class Surah {
  Surah(
      {@required this.id,
      @required this.arabicTitle,
      @required this.latinTitle,
      @required this.englishTitle,
      @required this.location,
      @required this.sajdah,
      @required this.numberOfAyah});

  final int id;
  final String arabicTitle;
  final String latinTitle;
  final String englishTitle;
  final int location;
  final int sajdah;
  final int numberOfAyah;

  Map<String, dynamic> toMap() => {
        'id': id,
        'arabicTitle': arabicTitle,
        'latinTitle': latinTitle,
        'englishTitle': englishTitle,
        'location': location,
        'sajdah': sajdah,
        'numberOfAyah': numberOfAyah,
      };

  factory Surah.fromMap(Map<String, dynamic> map) => Surah(
        id: map["id"],
        arabicTitle: map["arabicTitle"],
        latinTitle: map["latinTitle"],
        englishTitle: map["englishTitle"],
        location: map["location"],
        sajdah: map["sajdah"],
        numberOfAyah: map["numberOfAyah"],
      );
}
