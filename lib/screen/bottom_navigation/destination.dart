import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:line_icons/line_icons.dart';

class Destination {
  final String title;
  final Widget icon;
  final Color color;
  final Widget activeIcon;

  Destination({@required this.title, this.icon, this.color, this.activeIcon});
}

//List<Destination> allDestinations = [
//  Destination(title: 'Explore', icon: ImageIcon(AssetImage('assets/icons/explore.png'), size: 24,),),
//  Destination(title: 'Cart', icon: ImageIcon(AssetImage('assets/icons/cart.png'), size: 24,),),
//  Destination(title: 'Cart', icon: SCart(number:  4,),),
//  Destination(title: 'Favourite', icon: ImageIcon(AssetImage('assets/icons/fav.png',), size: 24,),),
//  Destination(title: 'Settings', icon: ImageIcon(AssetImage('assets/icons/settings.png'), size: 24,),),
//];

List<Destination> logisticsDestination = [
//  Destination(
//    title: 'Dashboard',
//    icon: Icon(LineIcons.bars,
//      size: 18,),
//    activeIcon: Icon(LineIcons.bars,
//        size: 24, color: Constants.yellow,),
//  ),
  Destination(
    title: 'Deliveries',
    icon: Icon(LineIcons.inbox,
        size: 18),
    activeIcon: Icon(LineIcons.inbox,
        size: 24, color: Constants.yellow),
  ),
  Destination(
    title: 'Address',
    icon: Icon(LineIcons.map_signs,
        size: 18),
    activeIcon: Icon(LineIcons.map_signs,
        size: 24, color: Constants.yellow),
  ),
  Destination(
    title: 'Rate Calculator',
    icon: Icon(LineIcons.calculator,
        size: 18),
    activeIcon: Icon(LineIcons.calculator,
        size: 24, color: Constants.yellow,),
  ),
];

