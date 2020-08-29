import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imospeed_user/provider/new_delivery_provider.dart';
import 'package:imospeed_user/screen/logistics/new_delivery/checkout_screen.dart';
import 'package:imospeed_user/screen/logistics/new_delivery/delivery_screen.dart';
import 'package:imospeed_user/screen/logistics/new_delivery/item_screen.dart';
import 'package:imospeed_user/screen/logistics/new_delivery/pick_up_screen.dart';
import 'package:imospeed_user/screen/logistics/new_delivery/rate_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:imospeed_user/util/margin.dart';
import 'package:provider/provider.dart';


class NewDeliveryScreen extends StatelessWidget {
//  @override
//  _NewDeliveryState createState() => _NewDeliveryState();
//}
//
//class _NewDeliveryState extends State<NewDeliveryScreen> {
  NewDeliveryProvider _provider;
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
//  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _provider.page ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Constants.darkAccent : Constants.darkAccent.withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    _provider = Provider.of<NewDeliveryProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        if(_provider.page > 0){
          _navigateToPrevPage();
          return false;
        }

        bool close = await showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  content: Text('Are you sure you want to close?', style: TextStyle(color: Constants.darkAccent)),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context, true);
//              Navigator.pushAndRemoveUntil(context,
//                  MaterialPageRoute(builder: (_) => HomeScreen()), (route) => true);
                        },
                        child: Text('Yes', style: TextStyle(color: Colors.red),)),
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('No', style: TextStyle(color: Constants.darkAccent),)),
                  ],
                ));
        return close;
//        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
//          brightness: Brightness.light,
//          elevation: 0,
          title: Text('New Delivery'),
          centerTitle: true,
//          backgroundColor: Constants.offWhite,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
//            color: Colors.black12,
          color: Constants.offWhite,
            width: screenWidth(context),
            height: screenHeight(context),
            padding: EdgeInsets.only(top: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                 YMargin(10),
                 Expanded(
                   child: PageView(
                     physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        _provider.setPage(page);
                      },
                      children: <Widget>[
                        PickUpScreen(pageController: _pageController,),
                        DeliveryScreen(pageController: _pageController,),
                        ItemScreen(pageController: _pageController,),
                        RateScreen(pageController: _pageController,),
                        CheckOutScreen(pageController: _pageController),
                      ],
                    ),
                 ),

              ],
            ),
          ),
        ),

      ),
    );
  }


  _navigateToPrevPage(){
    _pageController.animateToPage(_provider.page - 1, duration: Duration(milliseconds: 300), curve: Curves.linearToEaseOut);
    _provider.setPage(_provider.page - 1);
  }

}
