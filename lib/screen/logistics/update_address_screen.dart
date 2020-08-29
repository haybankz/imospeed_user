import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/request/address_request.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/title_text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UpdateAddressScreen extends StatefulWidget {

  final Address address;
  final AddressType addressType;

  UpdateAddressScreen({@required this.address, @required this.addressType});

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddressScreen> {
  AddressProvider _provider;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _phoneController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController =  TextEditingController(text: widget.address.person);
    _addressController = TextEditingController(text: widget.address.address);
    _phoneController = TextEditingController(text: widget.address.phone);
  }

  @override
  Widget build(BuildContext context) {
    _provider =  Provider.of<AddressProvider>(context);


    return Scaffold(
      backgroundColor: Constants.offWhite,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 2,
        title: Text('Update Address'),
        centerTitle: true,
      ),
      body: _updateAddressWidget(context),
    );
  }

  Widget _updateAddressWidget(BuildContext context){
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
            YMargin(10),
            Row(
              children: [
                Text('State:'),
                XMargin(5),
                Text('${widget.address.stateName}'),
              ],
            ),
            Row(
              children: [
                Text('Area:'),
                XMargin(5),
                Text('${widget.address.cityName}'),
              ],
            ),
            YMargin(10),

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
                loading: _provider.updateAddressResponse.status == Status.LOADING,
                text: 'Save',
                width: screenWidth(context),
                onPressed: () async{
                  FocusScope.of(context).requestFocus(FocusNode());
                  _formKey.currentState.save();
                  if(_formKey.currentState.validate()){
                    var request;
                    if(widget.addressType == AddressType.PICKUP) {
                      request = PickUpAddressRequest(addressType: Constants.kSource,
                          fromAddress: _addressController.text.trim(),
                          fromPerson: _nameController.text.trim(),
                          fromPhone: _phoneController.text.trim(),
                        stateFrom: widget.address.state,
                        cityFrom: widget.address.city
                      );
                    }else{
                      request = DeliveryAddressRequest(addressType: Constants.kDestination,
                          toAddress: _addressController.text.trim(),
                          toPerson: _nameController.text.trim(),
                          toPhone: _phoneController.text.trim(),
                        stateTo: widget.address.state,
                        cityTo: widget.address.city

                      );
                    }

                    ApiResponse<String> response = await _provider.updateAddress(widget.address.id, request);
                    if(response.status == Status.COMPLETED){
                      if(widget.addressType == AddressType.PICKUP){
                        _provider.getPickUpAddresses();
                      }else{
                        _provider.getDeliveryAddresses();
                      }
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
}