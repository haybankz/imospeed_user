import 'package:flutter/material.dart';
import 'package:imospeed_user/model/request/calculate_delivery_request.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:imospeed_user/widget/text_input.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget{

  final Item item;

  ItemWidget({@required this.item}) : assert(item != null);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        width: screenWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(

              child: Column(
//                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
////                      Text('Item name:', style: TextStyle(color: Colors.grey)),
////                      XMargin(6),
////                      Expanded(child: Text('${item.title}',
////                        style: TextStyle(fontWeight: FontWeight.w400, color: Constants.darkAccent),)),
//
//
//                    ],
//                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Item Name: ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${item.title}',
                          style: TextStyle(color: Constants.darkAccent, fontSize: 15, fontWeight: FontWeight.w500,),

                        ),
                      ],
                    ),
                  ),
                  YMargin(4),
//                  Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Text('Weight:', style: TextStyle(color: Colors.grey)),
//                      XMargin(6),
//                      Expanded(child: Text('${item.weight}Kg each',
//                        style: TextStyle(fontWeight: FontWeight.w400, color: Constants.darkAccent),)),
//                    ],
//                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Weight: ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${item.weight}Kg ',
                          style: TextStyle(color: Constants.darkAccent, fontSize: 15, fontWeight: FontWeight.w500,),

                        ),
                        TextSpan(
                          text: 'each',
                          style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400,),

                        ),
                      ],
                    ),
                  ),
                  YMargin(4),
//                  Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Text('Quantity:', style: TextStyle(color: Colors.grey)),
//                      XMargin(6),
//                      Expanded(child: Text('${item.quantity}',
//                        style: TextStyle(fontWeight: FontWeight.w400, color: Constants.darkAccent),)),
//                    ],
//                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Quantity: ',
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${item.quantity}',
                          style: TextStyle(color: Constants.darkAccent, fontSize: 15, fontWeight: FontWeight.w500,),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

                GestureDetector(
                  child: Icon(Icons.more_vert, color: Constants.yellow,),
                  onTapDown: (TapDownDetails details){
                    _showPopupMenu(context, details.globalPosition);
//                  _showDeleteDialog(context);
                  },
                ),


//            Row(
//              children: [
//                GestureDetector(
//                  child: Icon(Icons.edit, color: Constants.yellow,),
//                  onTapDown: (TapDownDetails details){
////                    _showPopupMenu(context, details.globalPosition);
//                  },
//                ),
//                XMargin(20),
//                GestureDetector(
//                  child: Icon(LineIcons.trash, color: Colors.red,),
//                  onTapDown: (TapDownDetails details){
////                    _showPopupMenu(context, details.globalPosition);
//                  _showDeleteDialog(context);
//                  },
//                ),
//              ],
//            )

          ],
        ),
      ),
    );
  }

  _showDeleteDialog(BuildContext context) async {
    bool close = await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              content: Text('Are you sure you want to delete this item(${item.title})?'),
              actions: <Widget>[
                Consumer<NewDeliveryProvider>(
                  builder: (ctx, provider, widget) =>  FlatButton(
                      onPressed: () {
                        provider.removeItem(item);

                      Navigator.pop(context, true);
//              Navigator.pushAndRemoveUntil(context,
//                  MaterialPageRoute(builder: (_) => HomeScreen()), (route) => true);

                      },
                      child: Text('Yes', style: TextStyle(color: Colors.red),)),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('No')),
              ],
            ));
  }

  _showEditItemDialog(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController(text: item.title);
    TextEditingController _weightController = TextEditingController(text: item.weight);
    TextEditingController _quantityController = TextEditingController(text: item.quantity);
    showDialog(context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
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
                Consumer<NewDeliveryProvider>(
                  builder: (context, provider, widget) => ButtonWidget(
                      width: screenWidth(context, percent: 0.7),
                      text: 'Edit', onPressed: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                    _formKey.currentState.save();
                    if(_formKey.currentState.validate()){
                      Item newItem = Item(title: _nameController.text.trim(),
                          weight: _weightController.text.trim(),
                          quantity: _quantityController.text.trim());
                      provider.editItem(item, newItem);
                      Navigator.pop(context);
                    }

                  }),
                ),
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

  _showPopupMenu(BuildContext context, Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    String answer = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),

      items: [
        PopupMenuItem<String>(
            child: const Text('Edit'), value: 'Edit'),
        PopupMenuItem<String>(
            child: const Text('Delete'), value: 'Delete'),
      ],
      elevation: 8.0,
    );

//    print(answer);

    if(answer == 'Edit'){
      _showEditItemDialog(context);
//      Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateAddressScreen(address: address, addressType: addressType)));
    }else if(answer == 'Delete'){
      _showDeleteDialog(context);
//      _showLoading(context);
//      ApiResponse<String> response =  await _provider.deleteAddress(addressType, address.id);
//      Navigator.pop(context);

//      if(response.status == Status.ERROR){
//        Toast.show(response.message, context);
//      }else{
//        Toast.show(response.data, context);
//      }

    }
  }
}