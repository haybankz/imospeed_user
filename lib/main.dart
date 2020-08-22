import 'package:flutter/material.dart';
import 'package:imospeed_user/locator.dart';
import 'package:imospeed_user/provider/app_provider.dart';
import 'package:imospeed_user/provider/auth_provider.dart';
import 'package:imospeed_user/provider/rate_calculator_provider.dart';
import 'package:imospeed_user/provider/state_provider.dart';
import 'package:imospeed_user/screen/add_address_screen.dart';
import 'package:imospeed_user/screen/landing_screen.dart';
import 'package:imospeed_user/screen/onboarding_screen.dart';
import 'package:imospeed_user/screen/rate_calculator_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StateProvider()),
        ChangeNotifierProvider(create: (_) => RateCalculatorProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
//          darkTheme: Constants.darkTheme,
//          home: RateCalculatorScreen(),
//          home: AddAddressScreen(addressType: AddressType.PICKUP),
          home: LandingScreen(),
        );
      },
    );
  }
}
