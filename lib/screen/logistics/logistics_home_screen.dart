import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/screen/bottom_navigation/destination.dart';
import 'package:imospeed_user/screen/bottom_navigation/destination_view.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';

class LogisticsHomeScreen extends StatefulWidget {
  @override
  _LogisticsHomeScreenState createState() => _LogisticsHomeScreenState();
}

class _LogisticsHomeScreenState extends State<LogisticsHomeScreen> with TickerProviderStateMixin<LogisticsHomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: screenHeight(context),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Constants.yellow.withOpacity(0.25), width: 1.5),),
          ),
          child: IndexedStack(
            index: _currentIndex,
            children: logisticsDestination.map<Widget>((Destination destination){
              return DestinationView(destination: destination,);
            }).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 20.0,
          unselectedFontSize: 12,
          selectedFontSize: 15,
//        unselectedItemColor: Colors.black87.withOpacity(0.8),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index){
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Constants.darkAccent,
          selectedIconTheme: IconThemeData(
            color: Constants.darkAccent,
          ),
          items: logisticsDestination.map((Destination destination){
            return BottomNavigationBarItem(
              icon: destination.icon,
//            backgroundColor: Color(0xffe0e0e0),
              title: Text('${destination.title}',),

              activeIcon: destination.activeIcon,
            );
          }).toList(),
        ),
      ),
    );
  }
}