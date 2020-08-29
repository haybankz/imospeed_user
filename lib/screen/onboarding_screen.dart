import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imospeed_user/screen/auth/login_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static final style = TextStyle(
    fontSize: 30,
//    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoardingScreen> {
  int page = 0;



  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 4.0 * zoom,
            height: 4.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final pages = [
      Container(
        color: Constants.darkAccent,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/imospeed_logo.png', height: 100, width: 150,),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            Column(
              children: <Widget>[
                Text(
                  "Hi",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "Lorem Ipsum",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "Lorem Ipsum Lorem Ipsum",
                  style: OnBoardingScreen.style,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Constants.yellow,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/imospeed_logo.png', height: 100, width: 150,),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            Column(
              children: <Widget>[
                Text(
                  "Take a",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "look at",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "Lorem Ipsum",
                  style: OnBoardingScreen.style,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Constants.lightAccent,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/imospeed_logo.png', height: 100, width: 150,),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            Column(
              children: <Widget>[
                Text(
                  "Liked?",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "Lorem Ipsum Ipsum",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "GLorem Ipsum",
                  style: OnBoardingScreen.style,
                ),
              ],
            ),
          ],
        ),
      ),
//      Container(
//        color: Constants.yellow,
//        width: double.infinity,
//        height: double.infinity,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            FlutterLogo(),
//            Padding(
//              padding: EdgeInsets.all(20.0),
//            ),
//            Column(
//              children: <Widget>[
//                Text(
//                  "Can be",
//                  style: OnBoardingScreen.style,
//                ),
//                Text(
//                  "Used for",
//                  style: OnBoardingScreen.style,
//                ),
//                Text(
//                  "Onboarding Design",
//                  style: OnBoardingScreen.style,
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
      Container(
        color: Constants.yellow,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/imospeed_logo.png', height: 100, width: 150,),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            Column(
              children: <Widget>[
                Text(
                  "Do",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "Try it",
                  style: OnBoardingScreen.style,
                ),
                Text(
                  "Lorem",
                  style: OnBoardingScreen.style,
                ),
                Container(
                  width: screenWidth(context, percent: 0.9),
                  padding: EdgeInsets.only(top: 20),

                  alignment: Alignment.bottomRight,
                  child: FlatButton(onPressed: () async{

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool(Constants.kFirstSeen, true);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
//                  pageChangeCallback(0);

                  }, child: Text("Get Started", style: TextStyle(color: Constants.lightAccent, fontSize: 18),)),
                )
              ],
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              fullTransitionValue: 900,
              enableSlideIcon: page < pages.length - 1,
              enableLoop: false,
              positionSlideIcon: 0.7,
              onPageChangeCallback: pageChangeCallback,
              currentUpdateTypeCallback: updateTypeCallback,
              waveType: WaveType.liquidReveal,


            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  pageChangeCallback(int lpage) {
//    print(lpage);
    setState(() {
      page = lpage;
    });
  }

  updateTypeCallback(UpdateType updateType) {
//    print(updateType);
  }
}