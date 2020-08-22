import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/address_item.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:imospeed_user/widget/title_text_input.dart';
import 'package:imospeed_user/widget/titled_drop_down.dart';

class AddAddressScreen extends StatelessWidget {
  final AddressType addressType;

  final _formKey = GlobalKey<FormState>();



  AddAddressScreen({@required this.addressType});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 2,
        title: Text('New ${addressType == AddressType.PICKUP ? 'Pickup' : 'Delivery'} Address'),
        centerTitle: true,
      ),
      backgroundColor: Constants.offWhite,
      body: _newAddressWidget(context),
    );
  }
  
  Widget _newAddressWidget(BuildContext context){
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
              Text('Address Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
              YMargin(10),
              _stateDropDown(),

              _neighbourhoodDropDown(),

              TitledTextInputWidget(controller: null, hintText: '12, Abuja Street', titleText: 'Enter street address', iconData: Icons.home,
              validator: (value){
                if(value.isEmpty) return 'Enter street address';
                return null;
              },),
              TextInputWidget(controller: null, hintText: 'Address 2 (optional)', iconData: Icons.home,),

              YMargin(20),
              Text('Contact Person', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
              YMargin(10),
              TitledTextInputWidget(controller: null, hintText: 'Mr Adekunle Ciroma', titleText: 'Name', validator: (value){
                if(value.isEmpty) return 'Enter contact person\'s name';
                    return null;
              },),

              TitledTextInputWidget(controller: null, hintText: '07089000000', titleText: 'Phone number', iconData: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value){
                if(value.isEmpty) return 'Enter contact person\'s phone number';
                return null;
              }),

              YMargin(20),

              ButtonWidget(text: 'Save',
                  width: screenWidth(context),
                  onPressed: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                  }),


            ],
          ),
        ),
      ),
    );
  }

  Widget _stateDropDown(){
    return TitledStateDropDownWidget( hintText: 'E.g Lagos', titleText: 'Select State', onSelect: (value){
      print('value: $value');
    },);
  }

  Widget _neighbourhoodDropDown(){
    return TitledStateDropDownWidget( hintText: 'E.g Agboyi/Ketu', titleText: 'Select Neighbourhood', onSelect: (value){
      print('value: $value');
    },);
  }
}

enum AddressType{PICKUP, DELIVERY}