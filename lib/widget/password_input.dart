import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';


class PasswordInput extends StatefulWidget {
//  Key key;
  final TextEditingController controller;
  final String hintText;
  final bool showObscure;
  final TextInputType keyboardType;
  final String Function(String) validator;

  PasswordInput({ @required this.controller, @required this.hintText, this.showObscure = false,
     this.keyboardType = TextInputType.visiblePassword, this.validator});

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  bool _obscureText = true;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextFormField(

                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                obscureText: _obscureText,
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true,
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
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                ),
                validator: widget.validator,
                maxLines: 1,
                controller: widget.controller,
              ),
            ),
            widget.showObscure ? SizedBox(
              width: 48,
              child: FlatButton(
                onPressed: _toggle,
                child: !_obscureText
                    ? ImageIcon(
                  AssetImage('assets/icons/hide_pass.png'),
                  color: Constants.lightAccent,
                  size: 16,
                )
                    : ImageIcon(
                  AssetImage('assets/icons/show_pass.png'),
                  color: Constants.lightAccent,
                  size: 16,
                ),
                splashColor: Colors.transparent,
//              color: Colors.white,
                highlightColor: Colors.transparent,
              ),
            ): XMargin(0),
          ],

        ),
      ),
    );
  }

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

}
