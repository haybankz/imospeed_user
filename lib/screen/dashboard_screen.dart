import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imospeed_user/provider/address_provider.dart';
import 'package:imospeed_user/provider/delivery_provider.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/provider/rate_calculator_provider.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/screen/logistics/my_address_screen.dart';
import 'package:imospeed_user/screen/logistics/new_delivery_screen.dart';
import 'package:imospeed_user/screen/logistics/rate_calculator_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:imospeed_user/widget/button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget{

  RateCalculatorProvider rateCalculatorProvider;
  NewDeliveryProvider newDeliveryProvider;

  List<_DashboardModel> list = [];

  @override
  Widget build(BuildContext context) {

    rateCalculatorProvider = Provider.of<RateCalculatorProvider>(context, listen: false);
    newDeliveryProvider = Provider.of<NewDeliveryProvider>(context, listen: false);

    list = [
      _DashboardModel(title: 'Deliver Now', icon: LineIcons.truck, onTap: (){

        newDeliveryProvider.reset();
        Navigator.push(context, MaterialPageRoute(builder: (_) => NewDeliveryScreen()));
      }),
      _DashboardModel(title: 'Book A Seat', icon: LineIcons.bookmark, onTap: (){

      }),
      _DashboardModel(title: 'Rate Calculator', icon: LineIcons.calculator, onTap: (){

        rateCalculatorProvider.reset();
        Navigator.push(context, MaterialPageRoute(builder: (_) => RateCalculatorScreen()));
      }),
      _DashboardModel(title: 'Track deliveries', icon: LineIcons.inbox, onTap: (){

      }),
    ];


    return Scaffold(
      backgroundColor: Constants.yellow.withOpacity(0.4),
//      body: Stack(
//        children: [
//          Image.asset('assets/images/fleet.jpg', width: screenWidth(context), height: screenHeight(context, percent: 0.5), fit: BoxFit.cover,),
//          Container(width: screenWidth(context), height: screenHeight(context, percent: 0.5), color: Constants.yellow.withOpacity(0.6),)
//        ],
//      )
//    body: DecoratedBox(
//      decoration: new BoxDecoration(
//        color: const Color(0xff7c94b6),
//        image: new DecorationImage(
//          fit: BoxFit.cover,
//          colorFilter: new ColorFilter.mode(Colors.purple.withOpacity(1.0), BlendMode.softLight),
//          image: new AssetImage(
//            'assets/images/fleet.jpg',
//          ),
//        ),
//      ),
//    ),
    body: Stack(
      children: [

        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Constants.offWhite, ],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height ));
          },
          blendMode: BlendMode.dstIn,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/fleet.jpg',
                height: screenHeight(context, percent: 1),
                width: screenWidth(context),
                fit: BoxFit.cover,
              ),
              
              Container(height: screenHeight(context, percent: 1),
                width: screenWidth(context),
              color: Constants.offWhite.withOpacity(0.7),),
            ],
          ),
        ),

        Container(height: screenHeight(context),
        width: screenWidth(context,),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              mainAxisSize: MainAxisSize.min,
//              children: [
//
//                Image.asset('assets/images/imospeed_logo.png', width: 80, height: 80,),
//
//              ],
//            ),
            YMargin(20),

//            SvgPicture.asset('assets/svg/welcome_cats.svg', width: screenWidth(context, percent: 0.7), height: screenHeight(context, percent: 0.15),),
          Image.asset('assets/images/imospeed_logo_square.png', width: screenWidth(context, percent: 0.7), height: screenHeight(context, percent: 0.15)),
YMargin(20),
            _items(),


          ],
        ),)
      ],
    ),
    );
  }

  Widget _items(){
    return AnimationLimiter(
      child: GridView(
        shrinkWrap: true,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),

        children: List.generate(list.length, (index){

          return AnimationConfiguration.staggeredGrid(
            columnCount: 2,
            position: index,
            duration: const Duration(milliseconds: 275),
            child:  ScaleAnimation(
                scale: 0.3,
                child: _DashboardItem(model: list[index],),)
          );
        }),


      ),
    );
  }
}


class _DashboardItem extends StatelessWidget{
  final _DashboardModel model;


  _DashboardItem({@required this.model });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
//                border: Border.all(color: Color(0xff9EE2A9), width: 0.5),
//              color: Color(0xffDEF9DE).withOpacity(0.8)
              color: Colors.white.withOpacity(0.7)
          ),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Container(
//                    padding: EdgeInsets.all(10),
//                    decoration:
//                    BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
//                    child: Icon(icon, size: 30, color: Colors.transparent,),
//                  ),
////            Icon(icon, size: 50,),
////            YMargin(20),
//                  Text('$title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.transparent),)
//                ],
//
//              ),
        ),

        InkWell(
          splashColor: Constants.darkAccent,
          onTap: model.onTap,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Constants.darkAccent.withOpacity(0.5), width: 0.8),
//              color: Color(0xffDEF9DE).withOpacity(0.8)
                color: Constants.lightAccent.withOpacity(0.25)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration:
                  BoxDecoration(
                    color: Constants.lightAccent.withOpacity(0.25), shape: BoxShape.circle,
//                    border: Border.all(color: Color(0xff9EE2A9), width: 0.5),
                  ),
                  child: Icon(model.icon, size: 28, color: Constants.darkAccent.withOpacity(0.7),),
                ),
//            Icon(icon, size: 50,),
//            YMargin(20),
                Text('${model.title}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Constants.darkAccent.withOpacity(0.8)),)
              ],

            ),
          ),
        ),
      ],
    );
  }
}

class _DashboardModel{
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _DashboardModel({this.title, this.icon, this.onTap});
}