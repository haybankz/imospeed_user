import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Constants{

  static String appName = "Imospeed";





  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff18BB3A);
//  static Color darkAccent = Color(0xff0A472C);
  static Color darkAccent = Color(0xff05400A);
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
    fontFamily: 'Poppins',
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


  static const String kFirstSeen = 'first_seen';
  static const String kToken = 'token';
  static const String kName = 'name';
  static const String kEmail = 'email';
  static const String kSource = 'source';
  static const String kDestination = 'destination';

  static const String kNaira = '\u{20A6}';

  static Widget smallEmpty = SvgPicture.asset('assets/svg/deliveries.svg',
    width: 50, height: 50,);

  static Widget empty = SvgPicture.asset('assets/svg/deliveries.svg',
    width: 100, height: 100,);

  static Widget error = SvgPicture.asset('assets/svg/cancel.svg',
    width: 100, height: 100,);

  static Widget smallError = SvgPicture.asset('assets/svg/cancel.svg',
    width: 50, height: 50,);


}