import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/screen/bottom_navigation/destination.dart';
import 'package:imospeed_user/screen/bottom_navigation/destination_view.dart';
import 'package:imospeed_user/util/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestination.map<Widget>((Destination destination){
            return DestinationView(destination: destination,);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 8.0,
        unselectedFontSize: 12,
        selectedFontSize: 14,
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
        items: allDestination.map((Destination destination){
          return BottomNavigationBarItem(
            icon: destination.icon,
//            backgroundColor: Color(0xffe0e0e0),
            title: Text('${destination.title}',),

            activeIcon: destination.activeIcon,
          );
        }).toList(),
      ),
    );
  }
}