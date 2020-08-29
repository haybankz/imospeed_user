import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/model/request/calculate_delivery_request.dart';
import 'package:imospeed_user/model/response/delivery_rate_response.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/item.dart';
import 'package:imospeed_user/widget/response_widget.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:imospeed_user/widget/title_text_input.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ItemScreen extends StatelessWidget{

  NewDeliveryProvider _provider;

  PageController pageController;
  ItemScreen({@required this.pageController});

  @override
  Widget build(BuildContext context) {

    _provider = Provider.of<NewDeliveryProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Constants.offWhite,
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showAddItemDialog(context);
      },
      backgroundColor: Constants.lightAccent,
      child: Icon(Icons.add, color: Colors.white,),),
      body: Column(
        children: [

          Center(child: Text('Items to be delivered', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Constants.darkAccent),)),
          YMargin(10),
          _itemList(context),
          YMargin(10),
          ButtonWidget(
            loading: _provider.rateResponse.status == Status.LOADING,
              text: 'Get Prices',
              onPressed: () async{

              if(_provider.items.length > 0){
//                _showLoading(context);
                ApiResponse<DeliveryRateResponse> response = await _provider.calculateRate();
//                Navigator.pop(context);
                if(response.status == Status.COMPLETED) {
                  pageController.animateToPage(
                      _provider.page + 1, duration: Duration(milliseconds: 300),
                      curve: Curves.linearToEaseOut);
                  _provider.setPage(_provider.page + 1);
                }else{
                  Toast.show(response.message, context, duration: Toast.LENGTH_LONG);
                }
              }else{
                Toast.show('Please add the items you wish to send', context, duration: Toast.LENGTH_LONG);
              }

          }),
          YMargin(10),
        ],
      ),
    );
  }

  Widget _itemList(BuildContext context){
    if(_provider.items.length > 0){
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _provider.items.length,
            itemBuilder: (context, index) => ItemWidget(item: _provider.items[index])),
      );
    }else{
      return Expanded(
//          height: screenHeight(context),
//          width: screenWidth(context),
          child: Center(child: Empty(message: 'No item added yet.\nClick on the \'+\' sign button to add your delivery items.',
            child: Constants.empty,)));
    }
  }

  void _showAddItemDialog(BuildContext context){
    var _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _weightController = TextEditingController();
    TextEditingController _quantityController = TextEditingController();
    showDialog(context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: Constants.offWhite,
      title: Text('Add Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInputWidget(controller: _nameController, hintText: 'Name of Item', iconData: Icons.description,
              validator: (value){
                if(value.length > 1) return null;
                return 'Enter a valid item name';
              },),
              YMargin(5),
              TextInputWidget(controller: _weightController, hintText: 'Weight per item (in KG)',  keyboardType: TextInputType.number, iconData: Icons.line_weight,
              validator: (value){
                if(value.length > 0) return null;
                return 'Enter item\'s weight in KG';
              },),
              YMargin(5),
              TextInputWidget(controller: _quantityController, hintText: 'Quantity of item', keyboardType: TextInputType.number,
                  iconData: Icons.format_list_numbered,
              validator: (value){
                if(value.length > 0) return null;
                return 'Enter a valid number for quantity';
              },),
              YMargin(10),
              ButtonWidget(
                  width: screenWidth(context, percent: 0.7),
                  text: 'Add', onPressed: (){
                FocusScope.of(context).requestFocus(FocusNode());
                _formKey.currentState.save();
                if(_formKey.currentState.validate()){
                  Item item = Item(title: _nameController.text.trim(),
                  weight: _weightController.text.trim(),
                  quantity: _quantityController.text.trim());
                  _provider.addItem(item);
                  Navigator.pop(context);
                }

              }),
              YMargin(10),
              ButtonWidget(
                  width: screenWidth(context, percent: 0.7),
                  text: 'Close', onPressed: (){
                Navigator.pop(context);
              }),
              YMargin(10),
            ],
          ),
        ),
      ),
//      actions: [
//        ButtonWidget(
//          width: screenWidth(context, percent: 0.7),
//            text: 'Add', onPressed: (){
//
//        }),
//        YMargin(10),
//        ButtonWidget(
//            width: screenWidth(context, percent: 0.7),
//            text: 'Close', onPressed: (){
//              Navigator.pop(context);
//        }),
//        YMargin(10),
//      ],
    ),
    );
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
                    valueColor: AlwaysStoppedAnimation<Color>(Constants.lightAccent),
                  ),),
                YMargin(10),
                Text('Getting Prices'),
              ],
            ),
          ),

        );
      },
    );
  }
}