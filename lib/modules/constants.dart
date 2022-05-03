import 'dart:collection';

import 'package:flutter/cupertino.dart';

const Color baseGreenColor = Color(0XFF50bb64);

const themeSet = {
  'lightTheme': {
    "baseColor": baseGreenColor,
    "textColor": Color.fromRGBO(0, 0, 0, 1),
    "backgroundColor": Color.fromRGBO(255, 255, 255, 1),
    "iconColor": Color.fromRGBO(0, 0, 0, 1),
  },
  'darkTheme': {
    "baseColor": baseGreenColor,
    "textColor": Color.fromRGBO(255, 255, 255, 1),
    "backgroundColor": Color.fromRGBO(0, 0, 0, 1),
    "iconColor": Color.fromRGBO(255, 255, 255, 1),
  },
};
