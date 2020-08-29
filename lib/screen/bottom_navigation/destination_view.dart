import 'package:flutter/material.dart';
import 'package:imospeed_user/screen/bottom_navigation/destination.dart';
import 'package:imospeed_user/screen/dashboard_screen.dart';
import 'package:imospeed_user/screen/dashboard_screen2.dart';
import 'package:imospeed_user/screen/logistics/deliveries_screen.dart';
import 'package:imospeed_user/screen/logistics/my_address_screen.dart';
import 'package:imospeed_user/screen/logistics/rate_calculator_screen.dart';

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
      case 'Rate Calculator': return RateCalculatorScreen();

      case 'Deliveries': return DeliveriesScreen();

      case 'Address': return MyAddressScreen();


      default: return Container(
          child: Center(
            child: Text('Undefined screen'),
          )
      );


    }
  }
}