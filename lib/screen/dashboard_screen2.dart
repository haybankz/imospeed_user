import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/delivery_provider.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/provider/rate_calculator_provider.dart';
import 'package:imospeed_user/screen/auth/login_screen.dart';
import 'package:imospeed_user/screen/logistics/logistics_home_screen.dart';
import 'package:imospeed_user/screen/logistics/new_delivery_screen.dart';
import 'package:imospeed_user/screen/logistics/rate_calculator_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen2 extends StatelessWidget{

  RateCalculatorProvider rateCalculatorProvider;
  NewDeliveryProvider newDeliveryProvider;

  List<_DashboardModel> list = [];

  @override
  Widget build(BuildContext context) {

    rateCalculatorProvider = Provider.of<RateCalculatorProvider>(context, listen: false);
    newDeliveryProvider = Provider.of<NewDeliveryProvider>(context, listen: false);

    list = [
      _DashboardModel(title: 'Deliver Now', icon: LineIcons.truck,
          image: 'assets/deliveries.svg',
          info: 'Deliver your goods from your address to anywhere in Nigeria', onTap: (){

        newDeliveryProvider.reset();
        Navigator.push(context, MaterialPageRoute(builder: (_) => LogisticsHomeScreen()));
      }),

      _DashboardModel(title: 'Book A Seat', icon: LineIcons.bus,info: 'Travel from your state to anywhere in Nigeria', onTap: (){

      }),
//      _DashboardModel(title: 'Rate Calculator', icon: LineIcons.calculator, onTap: (){
//
//        rateCalculatorProvider.reset();
//        Navigator.push(context, MaterialPageRoute(builder: (_) => RateCalculatorScreen()));
//      }),
//      _DashboardModel(title: 'Track deliveries', icon: LineIcons.inbox, onTap: (){
//
//      }),
    ];


    return Scaffold(
      backgroundColor: Constants.offWhite,
      body: Stack(
        children: [

          Card(
            margin: EdgeInsets.zero,
            elevation: 20,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ Colors.transparent, Constants.darkAccent,],
//              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height ));
                ).createShader(Rect.fromLTRB(rect.width, rect.height, 0, 0 ));
              },
              blendMode: BlendMode.colorDodge,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/fleet.jpg',
                    height: screenHeight(context, percent: 0.30),
                    width: screenWidth(context),
                    fit: BoxFit.cover,
                  ),

                  Container(height: screenHeight(context, percent: 0.30),
                    width: screenWidth(context),
                    color: Constants.darkAccent.withOpacity(0.6),),
                ],
              ),
            ),
          ),

          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                YMargin(screenHeight(context, percent:0.25)),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Constants.offWhite
                  ),
                  child: Container(
//                    color: Constants.offWhite,
                    width: screenWidth(context,),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Constants.yellow.withOpacity(0.25), width: 1.5),
//              color: Color(0xffDEF9DE).withOpacity(0.8)
                        color: Constants.yellow.withOpacity(0.6)
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Welcome, ',
                            style: TextStyle(color: Constants.darkAccent,),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Oga Moshood.',
                                style: TextStyle(color: Constants.darkAccent,  fontWeight: FontWeight.w500),

                              ),
                            ],
                          ),
                        ),
                        YMargin(10),
                        Text('We\'re really happy to have you here.', style: TextStyle(color: Constants.darkAccent,)),
                      ],
                    ),
                  ),
                ),

              myItems()

              ],
            ),
          ),

          Positioned(
            top: 30,
            right: 10,
//            child: Icon(Icons.more_vert, color: Constants.offWhite,),),
            child: FlatButton(
              onPressed: () async {
                bool close = await showDialog(
                    context: context,
                    builder: (_) =>
                        AlertDialog(
                          content: Text('Are you sure you want to log out?', style: TextStyle(color: Constants.darkAccent)),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Yes', style: TextStyle(color: Colors.red),)),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text('No', style: TextStyle(color: Constants.darkAccent),)),
                          ],
                        ));
                if(close){
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  for(String key in pref.getKeys()) {
                    if(key != Constants.kFirstSeen) {
                      pref.remove(key);
                    }
                  }
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);

                }
              },
              child: Text('Logout', style: TextStyle(color: Constants.offWhite),)),),


        ],
      ),
    );
  }



  Widget myItems(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        children: [
          _DashboardItem(model: list[0],),
//          YMargin(10),
          _DashboardItem(model: list[1],),
        ],
      ),
    );
  }


}


class _DashboardItem extends StatelessWidget{
  final _DashboardModel model;


  _DashboardItem({@required this.model });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      elevation: 0,

      child: Container(
        height: 150,
        child: Stack(
          children: [

            InkWell(
              splashColor: Constants.darkAccent.withOpacity(0.7),
              onTap: model.onTap,
              child: Container(
                width: screenWidth(context,),

                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Constants.lightAccent.withOpacity(0.25), width: 1.5),
//              color: Color(0xffDEF9DE).withOpacity(0.8)
                      color: Constants.lightAccent.withOpacity(0.25)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration:
                              BoxDecoration(
                                color: Constants.lightAccent.withOpacity(0.25), shape: BoxShape.circle,
//                    border: Border.all(color: Color(0xff9EE2A9), width: 0.5),
                              ),
                              child: Icon(model.icon, size: 20, color: Constants.darkAccent.withOpacity(0.7),),

                            ),
//                            YMargin(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth(context, percent: 0.6),
                                  child: Text('${model.title}',
//                                      textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constants.darkAccent.withOpacity(0.8)),),
                                ),

                                Container(
                                  width: screenWidth(context, percent: 0.6),
                                  child: Text('${model.info}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Constants.darkAccent.withOpacity(0.8),
                                        wordSpacing: 0.5, letterSpacing: 0.1),),
                                )
                              ],
                            ),




                          ],
                        ),
                      ),
//            Icon(icon, size: 50,),
                      Container(width: 10),


//                    Lottie.asset(
//                      'assets/lottie/imo_bus2.json',
//                      alignment: Alignment.bottomLeft,
////                  width: 50,
////                  height: 80,
//                      width: 100,
//                      height: 30,
//                      fit: BoxFit.cover,

//                    ),
                    ],

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardModel{
  final String title;
  final IconData icon;
  final String info;
  final String image;
  final VoidCallback onTap;

  _DashboardModel({this.title, this.icon, this.onTap, this.info = '', this.image = 'assets/svg/deliveries.svg'});
}