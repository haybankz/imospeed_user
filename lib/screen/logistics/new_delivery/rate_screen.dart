import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/rate_selector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class RateScreen extends StatefulWidget {



  PageController pageController;

  RateScreen({@required this.pageController});

  @override
  _RateState createState() => _RateState();
}
class _RateState extends State<RateScreen>{


  NewDeliveryProvider _provider;




  @override
  Widget build(BuildContext context) {

    _provider = Provider.of<NewDeliveryProvider>(context);
    return Scaffold(
      backgroundColor: Constants.offWhite,
//      width: screenWidth(context),
//      height: screenWidth(context),
      body: Column(
        children: [
          Center(child: Text('Select your preferred price', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),)),
          YMargin(10),
          _rateList(context),
          YMargin(10),
          ButtonWidget(text: 'Proceed to Check out', onPressed: () async {
//            await processTransaction(context);
          if(_provider.rate.amount != null) {
            widget.pageController.animateToPage(
                _provider.page + 1, duration: Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
            _provider.setPage(_provider.page + 1);
          }else{
            Toast.show('Select preferred price', context);
          }

          })
        ],
      ),
    );
  }

  Widget _rateList(BuildContext context){
    if((_provider.rateResponse.data?.response?.data ?? []).length > 0){
      return SingleChoiceRateChips(choices:  _provider.rateResponse.data?.response?.data, onChanged: (rate){
        _provider.setRate(rate);
      }, selectedId: _provider.rate.shipping_class_id);
    }else{
      return Container(
        width: screenWidth(context),
        height: screenWidth(context),
        child: Center(child:Text('Rate not available at the moment')),
      );
    }
  }


}