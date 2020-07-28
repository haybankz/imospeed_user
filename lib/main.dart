import 'package:flutter/material.dart';
import 'package:imospeed_user/provider/app_provider.dart';
import 'package:imospeed_user/screen/landing_screen.dart';
import 'package:imospeed_user/screen/onboarding_screen.dart';
import 'package:imospeed_user/util/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
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
          darkTheme: Constants.darkTheme,
//          home: SplashScreen(),
          home: LandingScreen(),
        );
      },
    );
  }
}
