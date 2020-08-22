import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/drop_down.dart';
import 'package:imospeed_user/widget/text_input.dart';

class RateCalculatorScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.offWhite,
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('From:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
              _fromState(),
              _fromLGA(),

              YMargin(6),

              Text('To:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
              _toState(),
              _toLGA(),

              YMargin(6),

              Text('Weight of Item(in KG):', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
              TextInputWidget(controller: null, hintText: '10', iconData: Icons.line_weight,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatter: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],),


              YMargin(20),
              ButtonWidget(text: 'Calculate Delivery Fee', onPressed: (){
                FocusScope.of(context).requestFocus(FocusNode());
              }),
              YMargin(10),



            ],
          ),
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
