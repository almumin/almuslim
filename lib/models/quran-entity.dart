import 'package:objectbox/objectbox.dart';

@Entity()
class QuranAyah {
  @Id(assignable: true)
  int id;
  int surahNumber;
  int ayahNumber;
  String arabicText;
  String englishTranslation;
  String transliteration;
  bool readAlready;
  bool isFavorite;
}

@Entity()
class Surahs {
  @Id(assignable: true)
  int id;
  String arabic;
  String arabicShort;
  String english;
  String latin;
  int ayah;
  int revelationOrder;
  int location;
  String type;
  int sajda;

  Surahs(
      {this.id,
      this.arabic,
      this.arabicShort,
      this.english,
      this.latin,
      this.ayah,
      this.revelationOrder,
      this.location,
      this.type,
      this.sajda});
}
