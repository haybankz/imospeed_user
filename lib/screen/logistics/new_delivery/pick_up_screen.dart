import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/address_selector.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/drop_down.dart';
import 'package:imospeed_user/widget/my_drop_down.dart';
import 'package:imospeed_user/widget/response_widget.dart';
import 'package:imospeed_user/widget/title_text_input.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


// ignore: must_be_immutable
class PickUpScreen extends StatefulWidget {

  PageController pageController;

  PickUpScreen({@required this.pageController});

  @override
  _PickUpState createState() => _PickUpState();
}

class _PickUpState extends State<PickUpScreen> {

  NewDeliveryProvider _newDeliveryProvider;
  AddressProvider _addressProvider;
  StateProvider _stateProvider;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _nameController.addListener(() {
//
//      Address address = _newDeliveryProvider.pickUpAddress;
//      address.id = '';
//      address.person = _nameController.text.trim();
//      _newDeliveryProvider.pickUpAddress = address;
//
//    });
//
//    _addressController.addListener(() {
//      Address address = _newDeliveryProvider.pickUpAddress;
//      address.id = '';
//      address.address = _addressController.text.trim();
//      _newDeliveryProvider.pickUpAddress = address;
//    });
//
//    _phoneController.addListener(() {
//      Address address = _newDeliveryProvider.pickUpAddress;
//      address.id = '';
//      address.phone = _phoneController.text.trim();
////      _newDeliveryProvider.setPickUpAddress(address);
//      _newDeliveryProvider.pickUpAddress = address;
//    });
    Future.delayed(Duration(milliseconds: 10), (){
      _nameController.text = _newDeliveryProvider.pickUpAddress.person;
      _addressController.text= _newDeliveryProvider.pickUpAddress.address;
      _phoneController.text= _newDeliveryProvider.pickUpAddress.phone;
    });

  }

  @override
  Widget build(BuildContext context) {

    _newDeliveryProvider = Provider.of<NewDeliveryProvider>(context);
    _addressProvider = Provider.of<AddressProvider>(context);
    _stateProvider = Provider.of<StateProvider>(context);

//    FocusScope.of(context).unfocus();

    return Scaffold(
//      width: screenWidth(context),
//      height: screenWidth(context),
      backgroundColor: Constants.offWhite,
      body: Form(
        key: _formKey,
        child: ListView(
//        mainAxisSize: MainAxisSize.max,
        shrinkWrap: true,
          children: [

            Center(child: Text('Select Pick up address', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),)),
            YMargin(5),
            _addressList(),
            _addressForm(context),
//        YMargin(10),
//        ButtonWidget(text: 'Next', onPressed: (){
//          widget.pageController.animateToPage(_newDeliveryProvider.page + 1, duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
//          _newDeliveryProvider.setPage(_newDeliveryProvider.page + 1);
//        })
          ],
        ),
      ),
    );
  }

  Widget _addressList(){
    if(_addressProvider.pickupAddressResponse.status == Status.LOADING){
      return Loading(loadingMessage: 'Getting Pick up addresses',);
    }else if(_addressProvider.pickupAddressResponse.status == Status.COMPLETED){
      List<Address> addresses = _addressProvider.pickupAddressResponse.data?.addresses ?? [];
      if(addresses.length > 0) {
        return SingleChoiceAddressChips(choices: addresses,
            selectedId: _newDeliveryProvider.pickUpAddress.id,
            onChanged: (address) {
              if (_newDeliveryProvider.pickUpAddress.id != address.id) {
                _newDeliveryProvider.getPickUpArea(int.parse(address.state));
              }

              _newDeliveryProvider.setPickUpAddress(address);
              _newDeliveryProvider.setPickAreaId(int.parse(address.city));

              _formKey.currentState.save();
              _navigateToNextPage();

//        print(address.id);
            });
      }else{
        return Container(
          color: Constants.offWhite,
          constraints: BoxConstraints(maxHeight: 120),
          child: Center(child: Empty(message: 'You don\'t have a pick up address saved yet.\n Save your pick up addresses to see them here',
            child: Constants.smallEmpty,)),
        );
      }


    }else{
      return Error(errorMessage: _addressProvider.pickupAddressResponse.message, onRetryPressed: (){
        _addressProvider.getPickUpAddresses();
      },);
    }
  }

  Widget _addressForm(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container(height: 1, color: Constants.yellow,)),
              XMargin(10),
              Text('OR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Constants.darkAccent),),
              XMargin(10),
              Expanded(child: Container(height: 1, color: Constants.yellow,)),
            ],
          ),
          YMargin(5),
          Text('Address Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Constants.darkAccent),),
//          YMargin(10),
          _state(),
          YMargin(4),
          _area(),
          YMargin(10),
          TitledTextInputWidget(controller: _addressController, hintText: '12, Abuja Street', titleText: 'Street Address', iconData: LineIcons.map_signs,
            validator: (value){
              if(value.isEmpty) return 'Enter street address';
              return null;
            },),
//            TextInputWidget(controller: null, hintText: 'Address 2 (optional)', iconData: Icons.home,),

          YMargin(10),
          Text('Contact Person', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Constants.darkAccent),),
          YMargin(10),
          TitledTextInputWidget(controller: _nameController, hintText: 'Mr Adekunle Ciroma', titleText: 'Name', iconData: LineIcons.user,validator: (value){
            if(value.isEmpty) return 'Enter contact person\'s name';
            return null;
          },),

          TitledTextInputWidget(controller: _phoneController, hintText: '07089000000', titleText: 'Phone Number', iconData: LineIcons.phone,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              validator: (value){
                if(value.length < 11) return 'Enter a valid phone number';
                return null;
              }),

          YMargin(20),

          ButtonWidget(
//                loading: _provider.saveAddressResponse.status == Status.LOADING,
              text: 'Continue',
              width: screenWidth(context),
              onPressed: () async{
                FocusScope.of(context).requestFocus(FocusNode());
                _formKey.currentState.save();
                if(_formKey.currentState.validate() && _newDeliveryProvider.pickUpStateId > 0 && _newDeliveryProvider.pickUpAreaId > 0){

                  Address address = Address(phone: _phoneController.text.trim(),
                      address: _addressController.text.trim(), person: _nameController.text.trim(),
                      city: _newDeliveryProvider.pickUpAreaId.toString(), state: _newDeliveryProvider.pickUpStateId.toString(),
                  cityName: _newDeliveryProvider.pickUpAreaName, stateName: _newDeliveryProvider.pickUpStateName);
                  _newDeliveryProvider.setPickUpAddress(address);

                  _navigateToNextPage();

                }else{
                  if(_newDeliveryProvider.pickUpStateId <= 0){
                    Toast.show("Please select a state", context, duration: Toast.LENGTH_LONG);
                  }
                  if(_newDeliveryProvider.pickUpAreaId <= 0){
                    Toast.show('Please select an area', context, duration: Toast.LENGTH_LONG);
                  }
                }
              }),
        ],
      ),
    );
  }

  Widget _state(){
//    return StateDropDownWidget(hintText: 'Select State',
//        onSelect: (value){
////      print(value);
//      _newDeliveryProvider.setPickUpStateId(int.parse(value));
//      _newDeliveryProvider.getArea(int.parse(value));
//
//      for(final state in _stateProvider.stateResponse.data.states){
//        if(state.id == int.parse(value)){
//          _newDeliveryProvider.pickUpAddress.id = '';
////          _newDeliveryProvider.pickUpAddress.stateName = state.name;
//          _newDeliveryProvider.setPickUpStateName(state.name);
//          break;
//        }
//      }
//
//    });

    return MyStateDropdownWidget(

      title: '',
//      items: ['Lagos', 'Ibadan'],
      currentItem: (_newDeliveryProvider.pickUpAddress.state ?? '').toString(),
      hintText: 'Select State',
      onChanged: (String value) {
//        this.status = status;
        print(value);

      _newDeliveryProvider.setPickUpStateId(int.parse(value));
      _newDeliveryProvider.getPickUpArea(int.parse(value));

      for(final state in _stateProvider.stateResponse.data.states){
        if(state.id == int.parse(value)){
          _newDeliveryProvider.pickUpAddress.id = '';
//          _newDeliveryProvider.pickUpAddress.stateName = state.name;
          _newDeliveryProvider.setPickUpStateName(state.name);
          break;
        }
      }
      },
    );
  }

  Widget _area(){
    if(_newDeliveryProvider.pickUpAreaResponse.status == Status.LOADING) {

      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text('Loading areas...', style: TextStyle(color: Constants.yellow, fontSize: 15),)
      );
    }else{
      try {
//        return AreaDropDownWidget(hintText: 'Select Neighbourhood',
//          onSelect: (value) {
//            _newDeliveryProvider.setPickAreaId(int.parse(value));
//            for(final area in _newDeliveryProvider.areaResponse.data.areaCities){
//              if(area.id == int.parse(value)){
//                _newDeliveryProvider.pickUpAddress.id = '';
////                _newDeliveryProvider.pickUpAddress.cityName = area.name;
//                _newDeliveryProvider.setPickUpAreaName(area.name);
//                break;
//              }
//            }
//          },
//          areas: _newDeliveryProvider.areaResponse.data.areaCities,);

        return MyAreaDropdownWidget(hintText: 'Select Neighbourhood',
          currentItem: (_newDeliveryProvider.pickUpAddress.city ?? '').toString(),
//          hintText: 'Select State',
          onChanged: (value) {
            _newDeliveryProvider.setPickAreaId(int.parse(value));
            for(final area in _newDeliveryProvider.pickUpAreaResponse.data.areaCities){
              if(area.id == int.parse(value)){
                _newDeliveryProvider.pickUpAddress.id = '';
//                _newDeliveryProvider.pickUpAddress.cityName = area.name;
                _newDeliveryProvider.setPickUpAreaName(area.name);
                break;
              }
            }
          },
          areas: _newDeliveryProvider.pickUpAreaResponse.data.areaCities,);
      }catch(e){
        return AreaDropDownWidget(hintText: 'Loading ...',
          onSelect: (value) {},
          areas: null,);
      }

    }
  }

  _navigateToNextPage(){
    widget.pageController.animateToPage(_newDeliveryProvider.page + 1, duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
    _newDeliveryProvider.setPage(_newDeliveryProvider.page + 1);
  }
}