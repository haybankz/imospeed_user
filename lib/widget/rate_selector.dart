import 'package:flutter/material.dart';
import 'package:imospeed_user/model/address.dart';
import 'package:imospeed_user/model/rate.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/utils.dart';
import 'package:provider/provider.dart';

class SingleChoiceRateChips extends StatefulWidget {
  final List<Rate> choices;
  final String selectedId;
  final Function(Rate) onChanged;

  SingleChoiceRateChips(
      {@required this.choices, @required this.onChanged, @required this.selectedId});

  @override
  _SSingleChoiceChipsState createState() => _SSingleChoiceChipsState();
}

class _SSingleChoiceChipsState extends State<SingleChoiceRateChips> {

//  AddressProvider _provider;

  @override
  Widget build(BuildContext context) {
//    _provider = Provider.of<AddressProvider>(context);
    return _listChoice(context);
  }

  _listChoice(BuildContext context) {
    return Consumer<NewDeliveryProvider>(
      builder: (ctx, model, w){
//        String selected = model.pickUpAddress.id;
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.choices.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Row(
//            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              XMargin(5),
              _RateChip(rate: widget.choices[index], selected: widget.choices[index].shipping_class_id == widget.selectedId, onSelect: widget.onChanged),
              XMargin(5),
            ],
          ),
        );},
    );
  }



}

class _RateChip extends StatelessWidget {

  final Rate rate;
  final bool selected;
  final Function(Rate) onSelect;

  _RateChip({@required this.rate, @required this.selected, @required this.onSelect});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Container(
//        width: screenWidth(context),
          decoration: BoxDecoration(
            color: !selected
                ? Colors.white
                : Constants.yellow.withOpacity(0.25),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: InkWell(
            onTap: (){
              onSelect(rate);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [

                  Container(
                    padding: EdgeInsets.all(6).add(EdgeInsets.symmetric(horizontal: 2)),
                    decoration: BoxDecoration(
                      color: selected
                          ? Constants.darkAccent.withOpacity(0.8)
                          : Constants.lightAccent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('${rate.shipping_class[0].toUpperCase()}${rate.shipping_class[1]}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Constants.offWhite,
                          fontWeight: FontWeight.w500),),
                  ),
                  XMargin(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${rate.shipping_class}', style: TextStyle(
                          color: selected
                              ? Constants.darkAccent
                              : Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),),
//                      YMargin(6),
                      RichText(
                        text: TextSpan(
                          text: '${Constants.kNaira}',
                          style: TextStyle(color: selected
                              ? Constants.darkAccent
                              : Constants.lightAccent, fontSize: 15, fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${ImoUtil.formatAmount(rate.amount.toDouble())}',
                              style: TextStyle(color: selected
                                  ? Constants.darkAccent
                                  : Constants.lightAccent, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),

                            ),
                          ],
                        ),
                      ),
//                  Text('${Constants.kNaira} ${ImoUtil.formatAmount(rate.amount.toDouble())}', style: TextStyle(
//                      color: selected
//                          ? Constants.darkAccent
//                          : Constants.lightAccent,
//                      fontWeight: FontWeight.w400,
//                      fontSize: 14),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



