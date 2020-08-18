import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/screen/onboarding_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget{

  @override
  _LandingState createState() => _LandingState();
}


class _LandingState extends State<LandingScreen> {

  startTimeout() {
    return  Timer(Duration(milliseconds: 500), checkFirstSeen);
  }

  Future checkFirstSeen() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    bool _seen = (prefs.getBool('seen') ?? false);
//
//
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    value = preferences.getInt("value");
//    if(value == 1){
//      Navigator.of(context).pushReplacement(
//          new MaterialPageRoute(builder: (context) => new MainScreen(),
//              settings: RouteSettings(name: 'home')));
//
//    }else if (_seen) {
//      Navigator.of(context).pushReplacement(
//          new MaterialPageRoute(builder: (context) => new JoinApp()));
//    } else {
//      await prefs.setBool('seen', true);
//      Navigator.of(context).pushReplacement(
//          new MaterialPageRoute(builder: (context) => new Walkthrough()));

//    }
          Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  @override
  void initState() {
    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
//        margin: EdgeInsets.only(left: 40.0, right: 40.0),
//        child: Center(
//          child: Image.asset('assets/images/imospeed_logo_square.png', height: 160, width: 160),
//        ),
      ),
    );
  }
}