import 'package:flutter/material.dart';
import 'package:imospeed_user/util/margin.dart';

class AddressItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3.0,
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
            Padding(
              padding: const EdgeInsets.only( right: 8.0),
              child: Icon(Icons.home),
            ),
            Expanded(

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Mr Oladele Abeeb,'),
                  YMargin(4),
                  Text('18, Oyebanjo street, Fadeyi, Ketu, Nassarawa'),
                  YMargin(4),
                  Text('Ketu, Lagos'),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
          ],
        ),
      ),
    );
  }
}