import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/screen/update_address_screen.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddressItem extends StatelessWidget{

  final Address address;
  final AddressType addressType;

  AddressItem({@required this.address, @required this.addressType}): assert(address != null);

  AddressProvider _provider;
  @override
  Widget build(BuildContext context) {

    _provider = Provider.of<AddressProvider>(context);

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
                  Text('${address.person},'),
                  YMargin(4),
                  Text('${address.address}'),
                  YMargin(4),
                  Text('${address.cityName}'),
                  YMargin(4),
                  Text('${address.stateName}'),
                ],
              ),
            ),

            GestureDetector(
              child: Icon(Icons.more_vert),
              onTapDown: (TapDownDetails details){
                _showPopupMenu(context, details.globalPosition);
              },
            )

          ],
        ),
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
      Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateAddressScreen(address: address, addressType: addressType)));
    }else if(answer == 'Delete'){
      _showLoading(context);
      ApiResponse<String> response =  await _provider.deleteAddress(addressType, address.id);
      Navigator.pop(context);

      if(response.status == Status.ERROR){
        Toast.show(response.message, context);
      }else{
        Toast.show(response.data, context);
      }

    }
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
            height: 60,
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Constants.lightAccent),
                  ),),
              ],
            ),
          ),

        );
      },
    );
  }
}