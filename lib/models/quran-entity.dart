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
