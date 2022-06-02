import 'package:flutter/material.dart';

MaterialColor PrimaryMaterialColor = MaterialColor(
  4294956367,
  <int, Color>{
    50: Color.fromRGBO(
      255,
      213,
      79,
      .1,
    ),
    100: Color.fromRGBO(
      255,
      213,
      79,
      .2,
    ),
    200: Color.fromRGBO(
      255,
      213,
      79,
      .3,
    ),
    300: Color.fromRGBO(
      255,
      213,
      79,
      .4,
    ),
    400: Color.fromRGBO(
      255,
      213,
      79,
      .5,
    ),
    500: Color.fromRGBO(
      255,
      213,
      79,
      .6,
    ),
    600: Color.fromRGBO(
      255,
      213,
      79,
      .7,
    ),
    700: Color.fromRGBO(
      255,
      213,
      79,
      .8,
    ),
    800: Color.fromRGBO(
      255,
      213,
      79,
      .9,
    ),
    900: Color.fromRGBO(
      255,
      213,
      79,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  brightness: Brightness.light,
  primaryColor: Color(0xffffd54f),
  primarySwatch: PrimaryMaterialColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Color(0xffffd54f),
      ),
    ),
  ),
);
