import 'package:flutter/material.dart';
class Constants{

  static String appName = "Imospped";
  static String baseUrl = "http://3.127.255.230/rest_ci/rest_ci_new/api";
//  static String authToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IkVucmd0ZWNoQCQhQDIwMjAtMjAi.Ru6DR2UOjSIJYYhEx216IhTzbbAuDdof-KQHJOu9umU";
//  static String restId = "1";





  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff18BB3A);
  static Color darkAccent = Color(0xff0A472C);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color textColor = Color(0xff014024);
  static Color yellow = Color(0xffF49D0E);
//  static Color ratingBG = Colors.yellow[600];
  static Color offWhite = Color(0xfff2f2f2);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: textColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    cursorColor: darkAccent,
    cardColor: darkBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );


  static const String kToken = 'token';
  static const String kName = 'name';

}