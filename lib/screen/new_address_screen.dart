import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/request/address_request.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/new_address_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/drop_down.dart';
import 'package:imospeed_user/widget/title_text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class NewAddressScreen extends StatelessWidget{

  final AddressType addressType;

  NewAddressScreen({@required this.addressType});


  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  AddressProvider _addressProvider;
  NewAddressProvider _provider;
  @override
  Widget build(BuildContext context) {
    _addressProvider = Provider.of<AddressProvider>(context);
    _provider = Provider.of<NewAddressProvider>(context);

    return Scaffold(
      backgroundColor: Constants.offWhite,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 2,
        title: Text('New ${addressType == AddressType.PICKUP ? 'Pick up' : 'Delivery'} address'),
        centerTitle: true,
      ),
      body: _newAddressWidget(context),
    );
  }

  Widget _newAddressWidget(BuildContext context){
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
            YMargin(10),
            _state(),
            _area(),

            TitledTextInputWidget(controller: _addressController, hintText: '12, Abuja Street', titleText: 'Enter street address', iconData: Icons.home,
              validator: (value){
                if(value.isEmpty) return 'Enter street address';
                return null;
              },),
//            TextInputWidget(controller: null, hintText: 'Address 2 (optional)', iconData: Icons.home,),

            YMargin(20),
            Text('Contact Person', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
            YMargin(10),
            TitledTextInputWidget(controller: _nameController, hintText: 'Mr Adekunle Ciroma', titleText: 'Name', validator: (value){
              if(value.isEmpty) return 'Enter contact person\'s name';
              return null;
            },),

            TitledTextInputWidget(controller: _phoneController, hintText: '07089000000', titleText: 'Phone number', iconData: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value){
                  if(value.length < 11) return 'Enter a valid phone number';
                  return null;
                }),

            YMargin(20),

            ButtonWidget(
              loading: _provider.saveAddressResponse.status == Status.LOADING,
                text: 'Save',
                width: screenWidth(context),
                onPressed: () async{
                  FocusScope.of(context).requestFocus(FocusNode());
                  _formKey.currentState.save();
                  if(_formKey.currentState.validate()){
                     var request;
                     if(addressType == AddressType.PICKUP) {
                       request = PickUpAddressRequest(addressType: 'source',
                           fromAddress: _addressController.text.trim(),
                           fromPerson: _nameController.text.trim(),
                           fromPhone: _phoneController.text.trim());
                     }else{
                       request = DeliveryAddressRequest(addressType: 'destination',
                            toAddress: _addressController.text.trim(),
                           toPerson: _nameController.text.trim(),
                           toPhone: _phoneController.text.trim()
                       );
                     }

                       ApiResponse<String> response = await _provider.saveAddress(addressType, request);
                       if(response.status == Status.COMPLETED){
                         Toast.show(response.data, context, duration: Toast.LENGTH_LONG);
                         Navigator.pop(context);
                       }else{
                         Toast.show(response.message, context, duration: Toast.LENGTH_LONG);
                       }

                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _state(){
    return StateDropDownWidget(hintText: 'Select State', onSelect: (value){
      print(value);
    _provider.getArea(int.parse(value));
    });
  }

  Widget _area(){
    if(_provider.areaResponse.status == Status.LOADING) {
//      return AreaDropDownWidget(hintText: 'Loading ...',
//        onSelect: (value) {},
//        areas: null,);
      return Text('Loading areas...');
    }else{
      try {
        return AreaDropDownWidget(hintText: 'Select Neighbourhood',
          onSelect: (value) {
            _provider.setAreaId(value);
          },
          areas: _provider.areaResponse.data.areaCities,);
      }catch(e){
        return AreaDropDownWidget(hintText: 'Loading ...',
          onSelect: (value) {},
          areas: null,);
      }

    }
  }

}