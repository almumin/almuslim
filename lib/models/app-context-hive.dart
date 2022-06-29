import 'dart:convert';

class ApplicationContext {
  String language;
  String theme;
  String calculationMethod;
  String highLatitudeRule;
  String madhab;
  Map<String, dynamic> prayerNotifications;

  ApplicationContext(
      {this.language,
      this.theme,
      this.calculationMethod,
      this.highLatitudeRule,
      this.madhab,
      this.prayerNotifications});

  // Ayah({@required this.index,@required this.surah,@required this.ayah,@required this.text});

  String toJson() => jsonEncode({
        'language': language,
        'theme': theme,
        'calculationMethod': calculationMethod,
        'highLatitudeRule': highLatitudeRule,
        'madhab': madhab,
        "prayerNotifications": prayerNotifications
      });

  Map<String, dynamic> toMap() => {
        'language': language,
        'theme': theme,
        'calculationMethod': calculationMethod,
        'highLatitudeRule': highLatitudeRule,
        'madhab': madhab,
        "prayerNotifications": prayerNotifications
      };

  factory ApplicationContext.fromJson(String data) {
    Map valueMap = json.decode(data);
    return ApplicationContext.fromMap(valueMap);
  }

  factory ApplicationContext.fromMap(Map<String, dynamic> map) =>
      ApplicationContext(
        language: map["language"],
        theme: map["theme"],
        calculationMethod: map["calculationMethod"],
        highLatitudeRule: map["highLatitudeRule"],
        madhab: map["madhab"],
        prayerNotifications: map[""],
      );
}
