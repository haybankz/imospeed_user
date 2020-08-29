import 'package:flutter/material.dart';
import 'package:imospeed_user/model/delivery.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/util/utils.dart';

class DeliveryItem extends StatelessWidget{

  final Delivery delivery;

  DeliveryItem({@required this.delivery}): assert(delivery != null);


  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        width: screenWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('From:', style: TextStyle(color: Colors.grey),),
                      XMargin(6),
                      Expanded(child: RichText(
                        text: TextSpan(
                          text: '${delivery.from_details.from_person},\n',
                          style: TextStyle(color: Constants.darkAccent, fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                                text: '${delivery.from_details.from_phone}\n',
                                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400,),

                            ),

                            TextSpan(
                              text: '${delivery.from_details.from_address},\n',
                              style: TextStyle(color: Constants.darkAccent, fontSize: 15, fontWeight: FontWeight.w400),

                            ),

                            TextSpan(
                              text: '${delivery.location_from},\n',
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),

                            ),
                            TextSpan(
                              text: '${delivery.state_from}',
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),

                            ),
                          ],
                        ),
                      ),),
                    ],
                  ),
                  YMargin(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To:    ', style: TextStyle(color: Colors.grey)),
                      XMargin(6),
                      Expanded(child: RichText(
                        text: TextSpan(
                          text: '${delivery.to_details.to_person},\n',
                          style: TextStyle(color: Constants.lightAccent, fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${delivery.to_details.to_phone}\n',
                              style: TextStyle(color: Colors.black54,  fontWeight: FontWeight.w400),

                            ),

                            TextSpan(
                              text: '${delivery.to_details.to_address},\n',
                              style: TextStyle(color: Constants.lightAccent, fontWeight: FontWeight.w400),

                            ),

                            TextSpan(
                              text: '${delivery.location_to},\n',
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),

                            ),
                            TextSpan(
                              text: '${delivery.state_to}',
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),

                            ),
                          ],
                        ),
                      ),),
                    ],
                  ),


                ],
              ),
            ),

            //status badge and price
            Column(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [


                Container(
                  padding: EdgeInsets.all(6).add(EdgeInsets.symmetric(horizontal: 2)),
                  decoration: BoxDecoration(
                    color: _getBadgeColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('${delivery.delivery_status[0].toUpperCase()}${delivery.delivery_status.substring(1)}',
                    style: TextStyle(
                        fontSize: 12,
                        color: _getBadgeColor(),
                        fontWeight: FontWeight.w500),),
                ),

                YMargin(50),

               RichText(
                  text: TextSpan(
                    text: '${Constants.kNaira}',
                    style: TextStyle(color: Constants.lightAccent, fontSize: 16, fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${ImoUtil.formatAmount(double.parse(delivery.cost))}',
                        style: TextStyle(color: Constants.lightAccent, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),

                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }


  Color _getBadgeColor(){

    switch(delivery.delivery_status){
      case 'cancelled':
        return Colors.red;
        break;
      case 'delivered' :
        return Constants.lightAccent;
        break;

      default:
        return Constants.yellow;

    }
  }

}