import 'package:flutter/material.dart';
import 'package:imospeed_user/util/constants.dart';

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

List<Destination> allDestination = [
  Destination(
    title: 'Dashboard',
    icon: Icon(Icons.home,
      size: 18,),
    activeIcon: Icon(Icons.home,
        size: 20, color: Constants.darkAccent,),
  ),
  Destination(
    title: 'Deliveries',
    icon: Icon(Icons.message,
        size: 18),
    activeIcon: Icon(Icons.message,
        size: 20, color: Constants.darkAccent),
  ),
//  Destination(
//    title: 'Favourite',
//    icon: SvgPicture.asset('assets/svg/fav_inactive.svg',
//        width: 18, height: 18),
//    activeIcon: SvgPicture.asset('assets/svg/fav_active.svg',
//        width: 20, height: 20),
//  ),
  Destination(
    title: 'More',
    icon: Icon(Icons.more_vert,
        size: 18),
    activeIcon: Icon(Icons.more_vert,
        size: 20, color: Constants.darkAccent,),
  ),
];

