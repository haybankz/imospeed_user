import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/util/constants.dart';


class TextInputWidget extends StatefulWidget {
//  Key key;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final IconData iconData;
  final List<TextInputFormatter> inputFormatter;

  TextInputWidget({ @required this.controller, @required this.hintText, this.keyboardType = TextInputType.text, this.validator,
    this.iconData = Icons.perm_identity, this.inputFormatter = const []});

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

  return Container(
    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
    margin: EdgeInsets.only(top: 10),
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
      inputFormatters: widget.inputFormatter,
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
  );
  }


}
