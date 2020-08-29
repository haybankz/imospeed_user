

import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:provider/provider.dart';

class SingleChoiceAddressChips extends StatefulWidget {
  final List<Address> choices;
  final String selectedId;
  final Function(Address) onChanged;

  SingleChoiceAddressChips(
      {@required this.choices, @required this.onChanged, @required this.selectedId});

  @override
  _SSingleChoiceChipsState createState() => _SSingleChoiceChipsState();
}

class _SSingleChoiceChipsState extends State<SingleChoiceAddressChips> {

//  AddressProvider _provider;

  @override
  Widget build(BuildContext context) {
//    _provider = Provider.of<AddressProvider>(context);
    return _listChoice(context);
  }

  _listChoice(BuildContext context) {

//        String selected = model.pickUpAddress.id;
        return Container(
          color: Constants.offWhite,
//          height: 80,
          constraints: BoxConstraints(maxHeight: 120),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.choices.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Row(
              children: <Widget>[
                XMargin(10),
                _AddressChip(address: widget.choices[index], selected: widget.choices[index].id == widget.selectedId, onSelect: widget.onChanged),
                XMargin(5),
              ],
            ),
          ),
        );

  }



}

class _AddressChip extends StatelessWidget {

  final Address address;
  final bool selected;
  final Function(Address) onSelect;

  _AddressChip({@required this.address, @required this.selected, @required this.onSelect});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
//        height: 200,
      constraints: BoxConstraints(maxHeight: 120),
        width: screenWidth(context, percent: 0.6),
        decoration: BoxDecoration(
          color: !selected
              ? Colors.white
              : Constants.yellow.withOpacity(0.3),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: InkWell(
          onTap: (){
            onSelect(address);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${address.person}', style: TextStyle(
                    color: selected
                        ? Constants.darkAccent
                        : Constants.lightAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),maxLines: 1, overflow: TextOverflow.ellipsis,),
                Text('${address.phone}', style: TextStyle(
                    color: selected
                        ? Constants.darkAccent
                        : Constants.lightAccent,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),maxLines: 1, overflow: TextOverflow.ellipsis,),
                Text('${address.address},', style: TextStyle(
                    color: selected
                        ? Constants.darkAccent
                        : Constants.lightAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),maxLines: 1, overflow: TextOverflow.ellipsis,),
                Expanded(
                  child: Text('${address.cityName},', style: TextStyle(
                      color: selected
                          ? Constants.darkAccent
                          : Constants.lightAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),maxLines: 1, overflow: TextOverflow.ellipsis,),
                ),
                Expanded(
                  child: Text('${address.stateName}.', style: TextStyle(
                      color: selected
                          ? Constants.darkAccent
                          : Constants.lightAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),maxLines: 1, overflow: TextOverflow.ellipsis,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



