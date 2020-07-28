import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final double width;
  final bool loading;

  ButtonWidget({@required this.text, @required this.onPressed, this.enabled = true, this.width = 0.0, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0.0 ? screenWidth(context,percent: 0.9) : width,

//      padding: EdgeInsets.only(top: 6, bottom: 6),
//      decoration: BoxDecoration(
////        color: yellow,
//        boxShadow: [
//          new BoxShadow(
//            offset: Offset(0, 0),
//            spreadRadius: -5,
//            color: yellow.withOpacity(0.7),
//            blurRadius: 10,
//          ),
//        ],
//      ),
      child: RaisedButton(
        elevation: 0,
        onPressed: enabled && !loading ? onPressed : (){},
        splashColor: Constants.darkAccent.withOpacity(0.2),
        color: Constants.darkAccent,
        child: !loading ? Text(
          text,
          style: TextStyle(color: Constants.lightPrimary, fontWeight: FontWeight.w600)
        ) : Container( height: 20, width: 20, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Constants.lightPrimary))
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.only(left: 0, right: 0, top: 13, bottom: 13),
      ),
    );
  }
}