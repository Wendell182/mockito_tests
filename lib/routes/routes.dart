import 'package:flutter/material.dart';

import '../pages/first_page.dart';
import '../pages/second_page.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => FirstPage(),
        );
      case '/second':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SecondPage(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => FirstPage(),
        );
    }
  }
}
