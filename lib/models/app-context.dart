
import 'package:objectbox/objectbox.dart';

@Entity()
class AppContext{
  @Id(assignable: true)
  int id;
  String language;
  String theme;
  String calculationMethod;
  String madhab;

  AppContext(this.language, this.theme);
}