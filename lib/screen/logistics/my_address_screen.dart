import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/new_address_provider.dart';
import 'package:imospeed_user/screen/logistics/new_address_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
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
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            XMargin(20),
            Image.asset('assets/images/imospeed_logo.png', width: 36, height: double.infinity,),
          ],
        ),
        title:Text('Addresses'),
        centerTitle: true,
      ),
        body: _myAddressWidget(context));
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
            heroTag: "pickupAddressBtn",
            onPressed: () {
              NewAddressProvider _pro = Provider.of<NewAddressProvider>(
                  context, listen: false);
              _pro.reset();
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  NewAddressScreen(addressType: AddressType.PICKUP,)));
            },
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Constants.lightAccent,),
          backgroundColor: Constants.offWhite,

          body: _pickupListContent((_provider.pickupAddressResponse.data?.addresses ?? []).length),
        );

    }else{
      return Error(errorMessage: _provider.pickupAddressResponse.message, onRetryPressed: (){
        _provider.getPickUpAddresses();
      },);
    }


  }

  Widget _pickupListContent(int length){
    if(length > 0){
      return ListView.builder(
          itemCount: _provider.pickupAddressResponse.data.addresses.length,
          itemBuilder: (context, index) =>
              AddressItem(address: _provider.pickupAddressResponse.data
                  .addresses[index], addressType: AddressType.PICKUP,));
    }else{
      return Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Center(child: Empty(message: 'You are yet to save a pickup address.\nGet started by pressing the \'+\' sign button',
            child: Constants.empty,)));
    }
  }

  Widget _deliveryList(BuildContext context){
    if(_provider.deliveryAddressResponse.status == Status.LOADING){
      return Loading(loadingMessage: 'Getting delivery addresses',);
    }else if(_provider.deliveryAddressResponse.status == Status.COMPLETED){

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: "deliveryAddressBtn",
            onPressed: () {
              NewAddressProvider _pro = Provider.of<NewAddressProvider>(
                  context, listen: false);
              _pro.reset();
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  NewAddressScreen(addressType: AddressType.DELIVERY,)));
            },
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Constants.lightAccent,),
          backgroundColor: Constants.offWhite,
          body: _deliveryListContent((_provider.deliveryAddressResponse.data?.addresses ?? []).length)
        );


    }else{
      return Error(errorMessage: _provider.deliveryAddressResponse.message, onRetryPressed: (){
        _provider.getDeliveryAddresses();
      },);
    }
  }

  Widget _deliveryListContent(int length){
    if(length > 0){
      return ListView.builder(
          itemCount: _provider.deliveryAddressResponse.data.addresses
              .length,
          itemBuilder: (context, index) =>
              AddressItem(address: _provider.deliveryAddressResponse.data
                  .addresses[index],
                addressType: AddressType.DELIVERY,));
    }else{
      return Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Center(child: Empty(message: 'You are yet to save a delivery address.\nGet started by pressing the \'+\' sign button',
            child: Constants.empty,)));
    }
  }
}