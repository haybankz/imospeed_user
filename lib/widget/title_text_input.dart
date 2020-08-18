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
        Card(
          margin: EdgeInsets.zero,
          elevation: 3.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
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
                  color: Colors.black,
                ),
              ),
              validator: widget.validator,
              maxLines: 1,
              controller: widget.controller,
            ),
          ),
        ),
        YMargin(10)
      ],
    );
  }


}
