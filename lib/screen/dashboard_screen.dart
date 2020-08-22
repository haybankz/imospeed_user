import 'package:flutter/material.dart';
import 'package:imospeed_user/provider/rate_calculator_provider.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/screen/rate_calculator_screen.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<StateProvider>(
            builder: (ctx, provider, widget) => ButtonWidget(text: 'Rate calculator',
                width: screenWidth(context),
                onPressed: (){
              provider.getStates();
              RateCalculatorProvider _p = Provider.of<RateCalculatorProvider>(context, listen: false);
              _p.reset();
              Navigator.push(context, MaterialPageRoute(builder: (_) => RateCalculatorScreen()));
            }),
          )
        ],
      ),
    );
  }
}