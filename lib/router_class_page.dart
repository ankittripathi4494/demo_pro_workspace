import 'package:demoproapp/modules/error/screens/internet_not_found_screen.dart';
import 'package:demoproapp/modules/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'modules/error/screens/page_not_found_screen.dart';
import 'modules/splash/screens/splash_screen.dart';

class RouterClass {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: const SplashScreen(),
        );
      case '/login':
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: const LoginScreen(),
        );
      case '/noInternet':
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: const InternetNotFoundScreen(),
        );
      default:
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: const PageNotFoundScreen(),
        );
    }
  }
}
