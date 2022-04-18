class CalculationMethods {
  static List<CalculationMethods> getMethods() => [
        CalculationMethods("muslim_world_league", "Muslim World League",
            "Fajr angle: 18, Isha angle: 17"),
        CalculationMethods("egyptian", "Egyptian General Authority of Survey",
            "Egyptian General Authority of Survey. Fajr angle: 19.5, Isha angle: 17.5"),
        CalculationMethods("karachi", "University of Islamic Sciences, Karachi",
            "University of Islamic Sciences, Karachi. Fajr angle: 18, Isha angle: 18"),
        CalculationMethods("umm_al_qura", "Umm al-Qura University, Makkah",
            "Umm al-Qura University, Makkah. Fajr angle: 18, Isha interval: 90. Note: you should add a +30 minute custom adjustment for Isha during Ramadan."),
        CalculationMethods(
            "north_america", "ISNA", "Fajr angle: 15, Isha angle: 15"),
        CalculationMethods("dubai", "UAE Method",
            "Method used in UAE. Fajr and Isha angles of 18.2 degrees."),
        CalculationMethods("qatar", "Qatar",
            "Modified version of Umm al-Qura used in Qatar. Fajr angle: 18, Isha interval: 90"),
        CalculationMethods("kuwait", "Kuwait",
            "Method used by the country of Kuwait. Fajr angle: 18, Isha angle: 17.5"),
        CalculationMethods("singapore", "Singapore",
            "	Method used by Singapore. Fajr angle: 20, Isha angle: 18."),
        CalculationMethods(
            "kuwait", "Kuwait", "Fajr angle: 18, Isha angle: 17.5"),
        CalculationMethods("other", "name", "	Fajr angle: 0, Isha angle: 0."),
      ];

  CalculationMethods(this.id, this.name, this.description);

  String id;
  String name;
  String description;
}
