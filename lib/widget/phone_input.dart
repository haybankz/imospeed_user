import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/util/margin.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String Function(String) validator;

  PhoneInput(
      {@required this.hintText,
        @required this.controller,
        this.validator});

  @override
  _PhoneInputState createState() {
    return _PhoneInputState();
  }
}

class _PhoneInputState extends State<PhoneInput> {


  String countryCode = '+234';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.only(left: 4, right: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          children: <Widget>[


//            CountryCodePicker(
////                    countryFilter: ['NG', 'GH', 'US', 'ZA'],
//              countryFilter: ['NG'],
//              onChanged: (value) {
//                setState(() {
////                        countryCode = value.dialCode.substring(1);
//                  countryCode = value.dialCode;
//                });
//
//                String num = '$countryCode$phoneNumber';
////                      widget.onChanged(num);
//                widget.controller.text = num;
//              },
//              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//              initialSelection: 'NG',
////                    favorite: [
////                      'NG',
////                    ],
//              // optional. Shows only country name and flag
//              showCountryOnly: false,
//              // optional. Shows only country name and flag when popup is closed.
//              showOnlyCountryWhenClosed: false,
//              // optional. aligns the flag and the Text left
//              alignLeft: false,
//            ),
//            XMargin(10),
            Expanded(
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                ),
                cursorColor: Color(0xff707070),
                keyboardType: TextInputType.phone,
                controller: widget.controller,
                validator: widget.validator,
                maxLength: 11,
                maxLengthEnforced: true,

//                onChanged: (value) {
//                  String phoneNum = '';
//                  if (value.startsWith('0')) phoneNum = value.substring(1);
//                  else phoneNum = value;
//
//                  setState(() {
//                    phoneNumber = phoneNum;
//                  });
//
//                  String num = '$countryCode$phoneNumber';
////                        widget.onChanged(num);
//                  widget.controller.text = num;
//                },
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
