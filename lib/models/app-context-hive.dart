import 'dart:convert';

import 'package:almuslim/modules/constants.dart';

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

  factory ApplicationContext.getDefaultsIfNotSet(String data) {
    Map valueMap = json.decode(data);
    ApplicationContext appContext = ApplicationContext.fromMap(valueMap);
    if (appContext.calculationMethod == null) {
      appContext.calculationMethod = defaultCalculationMethod;
    }
    if (appContext.highLatitudeRule == null) {
      appContext.highLatitudeRule = defaultHighLatitudeRule;
    }
    if (appContext.madhab == null) {
      appContext.madhab = defaultMadhab;
    }
    return appContext;
  }

  factory ApplicationContext.getDefaults() {
    ApplicationContext appContext = ApplicationContext();
    appContext.calculationMethod = defaultCalculationMethod;
    appContext.highLatitudeRule = defaultHighLatitudeRule;
    appContext.madhab = defaultMadhab;
    appContext.language = defaultLanguage;
    appContext.theme = defaultTheme;
    return appContext;
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
