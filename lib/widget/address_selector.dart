//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:imospeed_user/provider/address_provider.dart';
//import 'package:imospeed_user/util/margin.dart';
//import 'package:provider/provider.dart';
//
//class SSingleChoiceAddressChips extends StatefulWidget {
//  final List choices;
////  String selected;
//  final Function(String) onChanged;
//
//  SSingleChoiceAddressChips(
//      {@required this.choices, @required this.onChanged});
//
//  @override
//  _SSingleChoiceChipsState createState() => _SSingleChoiceChipsState();
//}
//
//class _SSingleChoiceChipsState extends State<SSingleChoiceAddressChips> {
////  String _selected = '';
//  AddressProvider _provider;
//
//  @override
//  Widget build(BuildContext context) {
//    _provider = Provider.of<AddressProvider>(context);
//    return _listChoice(context);
//  }
//
//  _listChoice(BuildContext context) {
//    return Consumer<CheckOutViewModel>(
//      builder: (ctx, model, w){
//        String selected = model.deliveryAddress.address_text;
//        return Container(
//          height: 30,
//          child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//            itemCount: widget.choices.length,
//            itemBuilder: (context, index) => Row(
//              children: <Widget>[
//                ChoiceChip(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(4.0),
//                    side: BorderSide(
//                      color: Color(0xff309378),
//                    ),
//                  ),
////            padding: EdgeInsets.all(0),
//                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//
//                  selectedColor: Color(0xff71dec0),
//                  labelPadding: EdgeInsets.all(-5),
////            clipBehavior: Clip.antiAlias,
//                  padding:
//                  EdgeInsets.only(left: 16, right: 16, top: -12, bottom: -12),
//
//                  labelStyle: TextStyle(
//                      color: selected == '${widget.choices[index]}'
//                          ? Colors.white
//                          : Color(0xff309378),
//                      fontWeight: FontWeight.w400,
//                      fontSize: 13),
//                  backgroundColor: Colors.white,
//                  label: Text('${widget.choices[index]}'),
//                  pressElevation: 5,
//                  selected: selected == '${widget.choices[index]}',
//                  onSelected: (bool selected) {
////                  setState(() {
////            if(_selected.contains('${widget.choices[index]}'))
////              _selected.remove('${widget.choices[index]}');
////            else _selected.add('${widget.choices[index]}');
//
//                    Address coordinate;
//                    for (Address address in addModel.allAddressResponse.data?.address) {
//                      if (address.address_text == widget.choices[index]) {
//                        coordinate = address;
//                        break;
//                      }
//                    }
//
//                    if(coordinate != null){
//                      List<String> co = coordinate.address_co_ordinate.split(',');
//                      double lat = double.parse(co[0]);
//                      double lng = double.parse(co[1]);
//                      a.LatLng latlng = a.LatLng(lat, lng);
//
//                      List<a.LatLng> vertices = List();
//                      List<Point> points = model.regionResponse.data.region.points;
//                      for(final point in points){
//                        vertices.add(a.LatLng(double.parse(point.lat), double.parse(point.long)));
//                      }
////                      bool withinRegion = _checkIfValidMarker(latlng, model);
//                      bool withinRegion = a.PolygonUtil.containsLocation(latlng, vertices, true);
//                      if(withinRegion){
//                        setState(() {
//                          widget.onChanged(widget.choices[index]);
//                        });
//                      }else{
//                        Toast.show('The selected address is not within the restaurant region.\nPlease select/add an address within the region', context);
//                      }
//                    }else{
//                      setState(() {
//                        widget.onChanged(widget.choices[index]);
//                      });
//                    }
//
//
//
////                  });
//                  },
//                ),
//                XMargin(10),
//              ],
//            ),
//          ),
//        );},
//    );
//  }
//
//
//}
