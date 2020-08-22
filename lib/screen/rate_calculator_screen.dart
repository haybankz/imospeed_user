import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/model/area_city.dart';
import 'package:imospeed_user/provider/rate_calculator_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/drop_down.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:provider/provider.dart';

class RateCalculatorScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  RateCalculatorProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<RateCalculatorProvider>(context);
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
                _provider.calculate();
              }),
              YMargin(10),



            ],
          ),
        ),
      ),
    );
  }

  Widget _fromState(){
    return StateDropDownWidget(hintText: 'Select State', onSelect: (value){
      _provider.getFromArea(int.parse(value));
    });
  }

  Widget _fromLGA(){
    if(_provider.fromAreaResponse.status == Status.LOADING) {
      return AreaDropDownWidget(hintText: 'Loading ...',
          onSelect: (value) {},
      areas: null,);
    }else{
//      if(_provider.fromAreaResponse.data == null){
//        return AreaDropDownWidget(hintText: 'Select LGA',
//          onSelect: (value) {},
//          areas: [],);
//      }else{
        return AreaDropDownWidget(hintText: 'Select Neighbourhood',
          onSelect: (value) {
          _provider.setFromAreaId(value);
          },
          areas: _provider.fromAreaResponse.data.areaCities,);
//      }
    }
  }


  Widget _toState(){
    return StateDropDownWidget(hintText: 'Select State', onSelect: (value){
      _provider.getToArea(int.parse(value));
    });
  }

  Widget _toLGA(){
    if(_provider.toAreaResponse.status == Status.LOADING) {
//      return AreaDropDownWidget(hintText: 'Select Neighbourhood', onSelect: (value) {}, areas: null,);
      return AreaDropDownWidget(hintText: 'Loading ...', onSelect: (value) {}, areas: null,);
    }else{
      return AreaDropDownWidget(hintText: 'Select Neighbourhood',
        onSelect: (value) {
        _provider.setToAreaId(value);
        },
        areas: _provider.toAreaResponse.data.areaCities,);
    }
  }
}
