import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imospeed_user/model/area_city.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:provider/provider.dart';


class StateDropDownWidget extends StatefulWidget {

  final String hintText;
//  String initialValue;
  final Function(String) onSelect;

  StateDropDownWidget({@required this.hintText, @required this.onSelect,});

  @override
  _StateDropDownState createState() => _StateDropDownState();
}

class _StateDropDownState extends State<StateDropDownWidget> {

  String currentSelectedValue;
  StateProvider _stateProvider;

  @override
  Widget build(BuildContext context) {

    _stateProvider = Provider.of<StateProvider>(context);
    final List<DropdownMenuItem> list = [
      DropdownMenuItem(
          value: '',
          child: Container(child: Text(widget.hintText, style: TextStyle(fontSize: 15, color: Constants.darkAccent),))),

    ];
    if(_stateProvider.stateResponse.status == Status.COMPLETED && _stateProvider.stateResponse.data != null){
      for(final state in _stateProvider.stateResponse.data.states){
        list.add(DropdownMenuItem(
            value: state.id.toString(),
            child: Container(child: Text(state.name, style: TextStyle(fontSize: 15, color: Constants.darkAccent),))));
      }
    }else{
      list.add(DropdownMenuItem(
          value: '',
          child: Container(child: Text('Loading states... Please wait', style: TextStyle(fontSize: 15, color: Constants.darkAccent),))));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Card(
          elevation: 0.5,
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
//                  value: widget.initialValue,
                  onChanged: (value) {
                    if(value.toString().isNotEmpty && value != currentSelectedValue) {
//                    if(value.toString().isNotEmpty && value != widget.initialValue) {
                      widget.onSelect(value);
                      setState(() {
                        currentSelectedValue = value;
//                        widget.initialValue = value;
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

class AreaDropDownWidget extends StatefulWidget {

  final String hintText;
  final List<AreaCity> areas;
  final Function(String) onSelect;

  AreaDropDownWidget({@required this.hintText, @required this.onSelect, this.areas});

  @override
  _AreaDropDownState createState() => _AreaDropDownState();
}

class _AreaDropDownState extends State<AreaDropDownWidget> {

  String currentSelectedValue;


  @override
  Widget build(BuildContext context) {

    final List<DropdownMenuItem> list = [
      DropdownMenuItem(
          value: '',
          child: Container(child: Text(widget.hintText, style: TextStyle(fontSize: 15, color: Constants.darkAccent),))),

    ];

    if(widget.areas != null) {
      for (final area in widget.areas) {
        list.add(DropdownMenuItem(
            value: area.id.toString(),
            child: Container(child: Text(area.name,
              style: TextStyle(fontSize: 15, color: Constants.darkAccent),))));
      }
    }
//    else{
//      list.add(DropdownMenuItem(
//          value: '',
//          child: Container(child: Text('Loading areas... Please wait', style: TextStyle(fontSize: 15, color: Constants.darkAccent),))));
//    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Card(
          elevation: 0.5,
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
                    if(value.toString().isNotEmpty && value != currentSelectedValue) {
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
