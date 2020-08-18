import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/drop_down.dart';

class RateCalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 2,
        title: Text('Rate Calculator'),
        centerTitle: true,
      ),
      body: _rateCalculatorWidget(context),
    );
  }

  Widget _rateCalculatorWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('From:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
            _fromState(),
            _fromLGA(),


            YMargin(10),
            Text('To:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
            _toState(),
            _toLGA(),

            YMargin(10),
            ButtonWidget(text: 'Calculate Delivery Fee', onPressed: (){}),
            YMargin(10),



          ],
        ),
      ),
    );
  }

  Widget _fromState(){
    return DropDownWidget(hintText: 'Select State', onSelect: (value){});
  }

  Widget _fromLGA(){
    return DropDownWidget(hintText: 'Select LGA', onSelect: (value){});
  }


  Widget _toState(){
    return DropDownWidget(hintText: 'Select State', onSelect: (value){});
  }

  Widget _toLGA(){
    return DropDownWidget(hintText: 'Select LGA', onSelect: (value){});
  }
}
