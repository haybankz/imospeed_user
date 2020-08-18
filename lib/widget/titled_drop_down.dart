import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';


class TitledDropDownWidget extends StatefulWidget {

  final String hintText;
  final String titleText;
  final Function(String) onSelect;

  TitledDropDownWidget({@required this.hintText,
    @required this.titleText, @required this.onSelect});

  @override
  _TitledTextInputState createState() => _TitledTextInputState();
}

class _TitledTextInputState extends State<TitledDropDownWidget> {

  var currentSelectedValue;


  @override
  Widget build(BuildContext context) {

    final List<DropdownMenuItem> list = [
      DropdownMenuItem(
          value: '',
          child: Container(child: Text(widget.hintText, style: TextStyle(fontSize: 15, color: Constants.darkAccent),))),

    ];

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.titleText, style: TextStyle(color: Colors.grey, fontSize: 14),),
        YMargin(2),
        Card(
          elevation: 3.0,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: list,
                  disabledHint: Text('Select one'),
                  hint: Text(widget.hintText),
                  isExpanded: true,
                  isDense: true,
                  value: currentSelectedValue,
                  onChanged: (value) {
                    if(value.toString().isNotEmpty) {
                      widget.onSelect(value);
                      setState(() {
                        currentSelectedValue = value;
                      });
                    }

                  }),
            ),
          ),
        ),
        YMargin(10),
      ],
    );
  }


}
