import 'package:flutter/material.dart';
import 'package:imospeed_user/provider/delivery_provider.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/screen/logistics/new_delivery_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/delivery_item.dart';
import 'package:imospeed_user/widget/response_widget.dart';
import 'package:imospeed_user/widget/tab.dart';
import 'package:provider/provider.dart';

class DeliveriesScreen extends StatelessWidget{

  DeliveryProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<DeliveryProvider>(context);
    return Scaffold(
      floatingActionButton: Consumer<NewDeliveryProvider>(

        builder: (ctx, provider, widget) =>  FloatingActionButton(
          heroTag: "deliveriesBtn",
          onPressed: (){
            provider.reset();
            Navigator.push(context, MaterialPageRoute(builder: (_) => NewDeliveryScreen()));
    },
      child: Icon(Icons.add, color: Colors.white,),
      backgroundColor: Constants.lightAccent,),
      ),
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
        title:Text('Deliveries'),
        centerTitle: true,
      ),
      body: _myDeliveriesWidget(context),
    );
  }

  Widget _myDeliveriesWidget(BuildContext context){
    List<String> tabTitles = ['Pending', 'Completed'];
    List<Widget> tabViews = [_pendingDeliveriesWidget(context), _completedDeliveriesWidget(context)];
    return TabWidget(tabs: tabTitles, views: tabViews) ;
  }

  Widget _pendingDeliveriesWidget(BuildContext context){
    if(_provider.deliveriesResponse.status == Status.LOADING){
      return Loading(loadingMessage: 'Getting deliveries...',);
    }else if(_provider.deliveriesResponse.status == Status.COMPLETED){
      if(_provider.pendingDelivery.length > 0 ){
        return ListView.builder(
          itemCount: _provider.pendingDelivery.length,
          itemBuilder: (context, index) => DeliveryItem(delivery: _provider.pendingDelivery[index]));
      }else{
        return Container(
          height: screenHeight(context),
            width: screenWidth(context),
            child: Center(child: Empty(message: 'You are yet to start a delivery.\nGet started by click the \'+\' sign button',
            child: Constants.empty,),));
      }
    }else{
      return Error(errorMessage: _provider.deliveriesResponse.message, onRetryPressed: (){
        _provider.getDeliveries();
      },);
    }
  }

  Widget _completedDeliveriesWidget(BuildContext context){
    if(_provider.deliveriesResponse.status == Status.LOADING){
      return Loading(loadingMessage: 'Getting deliveries...',);
    }else if(_provider.deliveriesResponse.status == Status.COMPLETED){
      if(_provider.completedDelivery.length > 0 ){
        return ListView.builder(
            itemCount: _provider.completedDelivery.length,
            itemBuilder: (context, index) => DeliveryItem(delivery: _provider.completedDelivery[index]));
      }else{
        return Container(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Center(child: Empty(message: 'You don\'t have a completed delivery yet.',
              child: Constants.empty,)));
      }
    }else{
      return Error(errorMessage: _provider.deliveriesResponse.message, onRetryPressed: (){
        _provider.getDeliveries();
      },);
    }
  }
}