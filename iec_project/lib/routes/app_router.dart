import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/pages/home_page.dart';

class AppRoute {
  // static Route onGenerateRoute(RouteSettings settings) {
  //   print("the name of route is ${settings.name}");

  //   switch (settings.name) {
  //     case '/':
  //       return HomePage.route();
  //     case HomePage.routeName:
  //       return HomePage.route();
  //     case SignIn.routeName;
  //     return SignIn.route();
  //     default:
  //       return _errorRoute();
  //   }
  // }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'), builder: (_) => HomePage());
  }
}
