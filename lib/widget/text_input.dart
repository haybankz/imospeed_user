import 'package:flutter/material.dart';


class TextInputWidget extends StatefulWidget {
//  Key key;
  final TextEditingController controller;
  final String hintText;
  final String titleText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final IconData iconData;

  TextInputWidget({ @required this.controller, @required this.hintText,
    this.titleText, this.keyboardType = TextInputType.text, this.validator,
    this.iconData = Icons.perm_identity});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInputWidget> {



  @override
  Widget build(BuildContext context) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(widget.titleText, style: TextStyle(color: Constants.),),
//        TextFormField(
//          style: bigTextStyle(),
//          cursorColor: off_white,
//          keyboardType: widget.keyboardType,
//          controller: widget.controller,
//          validator: widget.validator,
//          decoration: InputDecoration(
//            isDense: true,
//            enabledBorder: UnderlineInputBorder(
//              borderSide: BorderSide(color: off_white, width: 1),
//            ),
//            focusedBorder: UnderlineInputBorder(
//              borderSide: BorderSide(color: off_white, width: 2),
//            ),
//
//            hintText: widget.hintText,
//            hintStyle: bigTextStyle(color: off_white.withOpacity(0.5)),
//          ),
//
//        ),
//      ],
//    );

  return Card(
    elevation: 3.0,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextFormField(
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
  );
  }


}
