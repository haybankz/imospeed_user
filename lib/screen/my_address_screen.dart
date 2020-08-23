import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/new_address_provider.dart';
import 'package:imospeed_user/screen/new_address_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/widget/address_item.dart';
import 'package:imospeed_user/widget/response_widget.dart';
import 'package:imospeed_user/widget/tab.dart';
import 'package:provider/provider.dart';

class MyAddressScreen extends StatefulWidget {

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddressScreen>{

  AddressProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<AddressProvider>(context);
    return Scaffold(

      backgroundColor: Constants.offWhite,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        title: Text('My Addresses'),
        centerTitle: true,
      ),
      body: _myAddressWidget(context),
    );
  }

  Widget _myAddressWidget(BuildContext context){
    List<String> tabTitles = ['Pick up Addresses', 'Delivery Addresses'];
    List<Widget> tabViews = [_pickupList(context), _deliveryList(context)];
    return TabWidget(tabs: tabTitles, views: tabViews) ;
  }

  Widget _pickupList(BuildContext context){
    if(_provider.pickupAddressResponse.status == Status.LOADING){
      return Loading(loadingMessage: 'Getting pickup addresses',);
    }else if(_provider.pickupAddressResponse.status == Status.COMPLETED){
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            NewAddressProvider _pro = Provider.of<NewAddressProvider>(context, listen: false);
            _pro.reset();
            Navigator.push(context, MaterialPageRoute(builder: (_) => NewAddressScreen(addressType: AddressType.PICKUP,)));
          },
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Constants.lightAccent,),
        backgroundColor: Constants.offWhite,
        body: ListView.builder(
            itemCount: _provider.pickupAddressResponse.data.addresses.length,
            itemBuilder: (context, index) => AddressItem(address: _provider.pickupAddressResponse.data.addresses[index], addressType: AddressType.PICKUP,)),
      );
    }else{
      return Error(errorMessage: _provider.pickupAddressResponse.message, onRetryPressed: (){
        _provider.getPickUpAddresses();
      },);
    }


  }

  Widget _deliveryList(BuildContext context){
    if(_provider.deliveryAddressResponse.status == Status.LOADING){
      return Loading(loadingMessage: 'Getting delivery addresses',);
    }else if(_provider.deliveryAddressResponse.status == Status.COMPLETED){
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            NewAddressProvider _pro = Provider.of<NewAddressProvider>(context, listen: false);
            _pro.reset();
            Navigator.push(context, MaterialPageRoute(builder: (_) => NewAddressScreen(addressType: AddressType.DELIVERY,)));
          },
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Constants.lightAccent,),
        backgroundColor: Constants.offWhite,
        body: ListView.builder(
            itemCount: _provider.deliveryAddressResponse.data.addresses.length,
            itemBuilder: (context, index) => AddressItem(address: _provider.deliveryAddressResponse.data.addresses[index],
            addressType: AddressType.DELIVERY,)),
      );
    }else{
      return Error(errorMessage: _provider.deliveryAddressResponse.message, onRetryPressed: (){
        _provider.getDeliveryAddresses();
      },);
    }
  }
}