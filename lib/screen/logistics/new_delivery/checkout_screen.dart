import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/rate.dart';
import 'package:imospeed_user/model/request/calculate_delivery_request.dart';
import 'package:imospeed_user/model/response/submit_delivery_response.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/utils.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CheckOutScreen extends StatefulWidget {
  PageController pageController;

  CheckOutScreen({@required this.pageController});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOutScreen> {
  NewDeliveryProvider _provider;
  String paystackPublicKey = 'pk_test_6e0aca6c778426a30bdb07a3a7072522d1fad171';

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<NewDeliveryProvider>(context);

    return Scaffold(
      backgroundColor: Constants.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  height: 1,
                  color: Constants.yellow,
                )),
                XMargin(10),
                Text(
                  'Address Details',
                  style: TextStyle(fontSize: 15, color: Constants.darkAccent),
                ),
                XMargin(10),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Constants.yellow,
                )),
              ],
            ),
            YMargin(5),
            Container(
              constraints: BoxConstraints(maxHeight: 160),
              child: ListView(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  _AddressItem(address: _provider.pickUpAddress),
                  XMargin(10),
                  Center(
                    child: Icon(
                      LineIcons.long_arrow_right,
                      size: 28,
                    ),
                  ),
                  XMargin(10),
                  _AddressItem(address: _provider.deliveryAddress),
                ],
              ),
            ),
//            YMargin(5),
//            Row(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: [
//                Expanded(
//                    child: Container(
//                  height: 1,
//                  color: Constants.yellow,
//                )),
//                XMargin(10),
//                Text(
//                  'To',
//                  style: TextStyle(fontSize: 15, color: Constants.darkAccent),
//                ),
//                XMargin(10),
//                Expanded(
//                    child: Container(
//                  height: 1,
//                  color: Constants.yellow,
//                )),
//              ],
//            ),
//            YMargin(5),
//            _AddressItem(address: _provider.deliveryAddress),
            YMargin(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  height: 1,
                  color: Constants.yellow,
                )),
                XMargin(10),
                Text(
                  'Item Summary',
                  style: TextStyle(fontSize: 15, color: Constants.darkAccent),
                ),
                XMargin(10),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Constants.yellow,
                )),
              ],
            ),
            YMargin(5),
//            _itemList(),

            Container(
              constraints: BoxConstraints(maxHeight: 110),

              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _provider.items.length,
                itemBuilder: (context, index) => _ItemWidget(item: _provider.items[index]),
              ),
            ),

            YMargin(10),
//            YMargin(5),
//            Row(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: [
//                Expanded(
//                    child: Container(
//                  height: 1,
//                  color: Constants.yellow,
//                )),
//                XMargin(10),
//                Text(
//                  'Our Fee',
//                  style: TextStyle(fontSize: 15, color: Constants.darkAccent),
//                ),
//                XMargin(10),
//                Expanded(
//                    child: Container(
//                  height: 1,
//                  color: Constants.yellow,
//                )),
//              ],
//            ),
//            YMargin(5),
            _rate(_provider.rate),
            YMargin(20),
            ButtonWidget(
                text:
                    'Pay with Card',
                onPressed: () async {
                  CheckoutResponse checkOutResponse =
                      await processTransaction(context);
                  if (checkOutResponse.message.toLowerCase() == 'success') {
                    _showLoading(context);
                    ApiResponse<SubmitDeliveryResponse> response =
                        await _provider
                            .submitDelivery(checkOutResponse.reference);
                    Navigator.pop(context);
                    if (response.status == Status.COMPLETED) {
                      Toast.show('Delivery Submitted successfully', context,
                          duration: Toast.LENGTH_LONG);
                      Navigator.pop(context);
                    } else {
                      Toast.show(response.message, context,
                          duration: Toast.LENGTH_LONG);
                    }
                  } else {
                    Toast.show(checkOutResponse.message, context,
                        duration: Toast.LENGTH_LONG);
                  }

//                  widget.pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
//                  _provider.setPage(0);
                }),
            YMargin(20),
          ],
        ),
      ),
    );
  }

  Widget _itemList() {
    return Container(
      constraints:
          BoxConstraints(maxHeight: screenHeight(context, percent: 0.3)),
//      height: screenHeight(context, percent: 0.3),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _provider.items.length,
          itemBuilder: (context, index) =>
              _ItemWidget(item: _provider.items[index])),
    );
  }

  Widget _rate(Rate rate) {
//    print(rate.amount);
//    bool selected = true;
    return Container(
      width: screenWidth(context),
//      color: Constants.yellow.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Item Quantity: ',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Text(
                '${_provider.quantity}',
                style: TextStyle(color: Constants.darkAccent, fontSize: 15),
              ),
            ],
          ),
          YMargin(10),
          Row(
            children: [
              Text(
                'Total Item Weight: ',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                '${_provider.weight} Kg',
                style: TextStyle(color: Constants.darkAccent, fontSize: 14),
              ),
            ],
          ),
          YMargin(10),
          Row(
            children: [
              Text(
                'Delivery Type: ',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Text(
                '${rate.shipping_class}',
                style: TextStyle(color: Constants.darkAccent, fontSize: 15),
              ),
            ],
          ),
          YMargin(10),
          Container(
            color: Colors.grey.withOpacity(0.3),
            height: 0.6,
          ),
          YMargin(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cost: ',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              RichText(
                text: TextSpan(
                  text: '${Constants.kNaira}',
                  style: TextStyle(color: Constants.darkAccent, fontSize: 18, fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${ImoUtil.formatAmount(rate.amount.toDouble())}',
                      style: TextStyle(color: Constants.darkAccent, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<CheckoutResponse> processTransaction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString(Constants.kName);
    String email = prefs.getString(Constants.kEmail);

    String fname = fullName.split(' ')[0];
    String lname = fullName.split(' ')[1];

    String reference = _getReference(email);
    print(reference);

    Charge charge = Charge()
      ..amount = (_provider.rate.amount * 100).floor()
      ..reference = reference
      ..putMetaData('first_name', fname)
      ..putMetaData('last_name', lname)
      ..email = email;

    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    print(response);
    return response;
  }

  String _getReference(String email) {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'Imospeed_${platform}_${email}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void _showLoading(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: Container(
//            height: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Constants.lightAccent),
                  ),
                ),
                YMargin(10),
                Text('Submitting your delivery'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddressItem extends StatelessWidget {
  final Address address;

  _AddressItem({@required this.address}) : assert(address != null);

//  AddressProvider _provider;
  @override
  Widget build(BuildContext context) {
//    _provider = Provider.of<AddressProvider>(context);

    return Card(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        width: screenWidth(context, percent: 0.5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only( right: 8.0),
//              child: Icon(Icons.home),
//            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${address.person},', style: TextStyle(color: Constants.darkAccent, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, maxLines: 1,),
                  Text('${address.phone},', style: TextStyle(color: Constants.darkAccent,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                  YMargin(4),
                  Text('${address.address}', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, maxLines: 1,),
//                  YMargin(4),
                  Text('${address.cityName}', style: TextStyle(color: Constants.darkAccent,), overflow: TextOverflow.ellipsis, maxLines: 1,),
//                  YMargin(4),
                  Text('${address.stateName}', style: TextStyle(color: Constants.darkAccent,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                ],
              ),
            ),

//            GestureDetector(
//              child: Icon(Icons.more_vert),
//              onTapDown: (TapDownDetails details){
//                _showPopupMenu(context, details.globalPosition);
//              },
//            )
          ],
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final Item item;

  _ItemWidget({@required this.item}) : assert(item != null);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        width: screenWidth(context, percent: 0.65),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Expanded(
              child: Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Item name:',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        XMargin(6),
                        Expanded(
                            child: Text(
                          '${item.title}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Constants.darkAccent,
                              fontSize: 14),
                        )),
                      ],
                    ),
                    YMargin(4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight:',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        XMargin(6),
                        Expanded(
                            child: Text(
                          '${item.weight} Kg',
                          style: TextStyle(
                              color: Constants.darkAccent,
                              fontSize: 14),
                        )),
                      ],
                    ),
//                  YMargin(4),
//                  Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Text('Quantity:',
//                          style: TextStyle(color: Colors.grey, fontSize: 14)),
//                      XMargin(6),
//                      Expanded(
//                          child: Text(
//                        '${item.quantity}',
//                        style: TextStyle(
//                            color: Constants.darkAccent,
//                            fontSize: 14),
//                      )),
//                    ],
//                  ),

                  ],
                ),
              ),
            ),
            XMargin(6),
            Container(
              padding: EdgeInsets.all(10),
              decoration:
              BoxDecoration(
                color: Constants.lightAccent.withOpacity(0.25), shape: BoxShape.circle,
//                    border: Border.all(color: Color(0xff9EE2A9), width: 0.5),
              ),
              child: Text(
                '${item.quantity}',
                style: TextStyle(
                    color: Constants.darkAccent,
                    fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
