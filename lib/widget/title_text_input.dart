import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';


class TitledTextInputWidget extends StatefulWidget {
//  Key key;
  final TextEditingController controller;
  final String hintText;
  final String titleText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final IconData iconData;

  TitledTextInputWidget({ @required this.controller, @required this.hintText,
    @required this.titleText, this.keyboardType = TextInputType.text, this.validator,
    this.iconData = Icons.perm_identity});

  @override
  _TitledTextInputState createState() => _TitledTextInputState();
}

class _TitledTextInputState extends State<TitledTextInputWidget> {



  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.titleText, style: TextStyle(color: Colors.grey, fontSize: 14),),
        YMargin(2),
        Container(
//          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
//          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 10,
                color: Color(0x19000000),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
              prefixIcon: Icon(
                widget.iconData,
                color: Constants.darkAccent,
              ),
            ),
            validator: widget.validator,
            maxLines: 1,
            controller: widget.controller,
          ),
        ),
        YMargin(10)
      ],
    );
  }


}
