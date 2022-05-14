import 'package:objectbox/objectbox.dart';

@Entity()
class QuranAyah {
  @Id(assignable: true)
  int id;
  int surahNumber;
  int ayahNumber;
  String text;
  String englishText;
}

@Entity()
class Surahs {
  @Id(assignable: true)
  int id;
  String name;
  int ayah;
  int revelationOrder;
  String type;
  int startAyah;
  int endAyah;

  Surahs({this.id, this.name, this.ayah, this.revelationOrder, this.type, this.startAyah, this.endAyah});
}
