import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';

const Color baseGreenColor = Color(0XFF50bb64);
const String defaultCalculationMethod = 'north_america';
const Madhab defaultMadhab = Madhab.shafi;

const themeSet = {
  'lightTheme': {
    "baseColor": baseGreenColor,
    "secondaryBaseColor": Color(0xFF9CCC65),
    "textColor": Color.fromRGBO(0, 0, 0, 1),
    "backgroundColor": Color.fromRGBO(255, 255, 255, 1),
    "iconColor": Color.fromRGBO(0, 0, 0, 1),
  },
  'darkTheme': {
    "baseColor": baseGreenColor,
    "secondaryBaseColor": Color(0xFF33691E),
    "textColor": Color.fromRGBO(255, 255, 255, 1),
    "backgroundColor": Color.fromRGBO(0, 0, 0, 1),
    "iconColor": Color.fromRGBO(255, 255, 255, 1),
  },
};
