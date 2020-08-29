import 'package:flutter/material.dart';
import 'package:imospeed_user/model/area_city.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/service/api_response.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:provider/provider.dart';


class MyStateDropdownWidget extends StatefulWidget {
  final String title;
//  final List<String> items;
  final ValueChanged<String> onChanged;
  final String currentItem;
  final String hintText;



  MyStateDropdownWidget({
    this.title,
//    this.items,
    this.onChanged,
    this.currentItem,
    this.hintText,
  });

  @override
  State<StatefulWidget> createState() => _StateDropdownState(currentItem);
}

class _StateDropdownState extends State<MyStateDropdownWidget> {
//  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;
  StateProvider _stateProvider;
//  AppTheme appTheme;

  _StateDropdownState(this.currentItem);

  @override
  void initState() {
    super.initState();
//    for (String item in widget.items) {

//      dropDownItems.add(DropdownMenuItem(
//        value: item,
//        child: Text(
//          item,
//          style: TextStyle(
//            fontSize: 16,
//          ),
//        ),
//      ));
//    }
  }

  @override
  void didUpdateWidget(MyStateDropdownWidget oldWidget) {
    if (this.currentItem != widget.currentItem) {
      setState(() {
        this.currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _stateProvider = Provider.of<StateProvider>(context);
//    appTheme = AppTheme(Theme.of(context).brightness);

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

    return Container(
//      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          Container(
//            margin: EdgeInsets.only(left: 6),
//            child: Text(
//              widget.title,
////              style: appTheme.activityAddPageTextStyle,
//            ),
//          ),
          Container(
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
//                icon: appTheme.activityAddPageDownArrowSVG,
                value: currentItem,
                isExpanded: true,
                items: list,
                onChanged: (selectedItem) {

                  if(selectedItem != currentItem && selectedItem.toString().isNotEmpty) {
                    setState(() {
                      currentItem = selectedItem;
                      widget.onChanged(currentItem);
                    });
                  }


                },
                hint: Container(
                  child: Text(widget.hintText,
//                      style: appTheme.hintStyle
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MyAreaDropdownWidget extends StatefulWidget {
  final String title;
//  final List<String> items;
  final List<AreaCity> areas;
  final ValueChanged<String> onChanged;
  final String currentItem;
  final String hintText;

  MyAreaDropdownWidget({
    this.title,
    @required this.areas,
    this.onChanged,
    this.currentItem,
    this.hintText,
  });

  @override
  _MyAreaDropdownState createState() => _MyAreaDropdownState(currentItem,);
}

class _MyAreaDropdownState extends State<MyAreaDropdownWidget> {
//  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;

//  AppTheme appTheme;

  _MyAreaDropdownState(this.currentItem, );

  @override
  void initState() {
    super.initState();
//    for (String item in widget.items) {
//      dropDownItems.add(DropdownMenuItem(
//        value: item,
//        child: Text(
//          item,
//          style: TextStyle(
//            fontSize: 16,
//          ),
//        ),
//      ));
//    }
  }

  @override
  void didUpdateWidget(MyAreaDropdownWidget oldWidget) {
    if (this.currentItem != widget.currentItem) {
      setState(() {
        this.currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
//    appTheme = AppTheme(Theme.of(context).brightness);

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
    return Container(
//      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Container(
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
//                icon: appTheme.activityAddPageDownArrowSVG,
                value: currentItem,
                isExpanded: true,
                items: list,
                onChanged: (selectedItem) {
//                  if (selectedItem.toString().isEmpty) selectedItem = '';
                  if (selectedItem != currentItem && selectedItem.toString().isNotEmpty) {
                    setState(() {
                      currentItem = selectedItem;
                      widget.onChanged(currentItem);
                    });
                  }
                },
                hint: Container(
                  child: Text(widget.hintText,
//                      style: appTheme.hintStyle
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}