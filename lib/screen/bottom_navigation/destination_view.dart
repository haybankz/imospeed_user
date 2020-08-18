import 'package:flutter/material.dart';
import 'package:imospeed_user/screen/bottom_navigation/destination.dart';
import 'package:imospeed_user/screen/dashboard_screen.dart';
import 'package:imospeed_user/screen/deliveries_screen.dart';
import 'package:imospeed_user/screen/more_screen.dart';

class DestinationView extends StatefulWidget {

  final Destination destination;

  DestinationView({@required this.destination});

  @override
  _DestinationView createState() => _DestinationView();
}

class _DestinationView extends State<DestinationView> {

  @override
  Widget build(BuildContext context) {
    switch(widget.destination.title){
//      case 'Explore': return ExploreScreen();
      case 'Dashboard': return DashBoardScreen();

      case 'Deliveries': return DeliveriesScreen();

//      case 'Favourite': return FavouriteScreen();

      case 'More': return MoreScreen();

      default: return Container(
          child: Center(
            child: Text('Undefined screen'),
          )
      );


    }
  }
}