import 'package:demoproapp/modules/crud_with_api_with_bloc/screens/user_group_list.dart';
import 'package:demoproapp/modules/crud_with_db_without_singleton/screens/update_screen.dart';
import 'package:demoproapp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:demoproapp/modules/error/screens/internet_not_found_screen.dart';
import 'package:demoproapp/modules/login/login_bloc/login_bloc.dart';
import 'package:demoproapp/modules/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'modules/crud_with_db_with_singleton/screens/create_screen.dart';
import 'modules/crud_with_db_with_singleton/screens/read_screen.dart';
import 'modules/crud_with_db_with_singleton/screens/update_screen.dart';
import 'modules/crud_with_db_without_singleton/screens/create_screen.dart';
import 'modules/crud_with_db_without_singleton/screens/read_screen.dart';
import 'modules/error/screens/page_not_found_screen.dart';
import 'modules/splash/screens/splash_screen.dart';

class RouterClass {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    var arguments = settings.arguments;
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
          child: BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginScreen(),
          ),
        );
      case '/dashboard':
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: const DashboardScreen(),
        );
      case '/crud1/create':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: CreateScreenCrudDBOne(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: CreateScreenCrudDBOne(
            args: const {},
          ),
        );
      case '/crud1/read':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: ReadScreenCrudDBOne(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: ReadScreenCrudDBOne(
            args: const {},
          ),
        );
      case '/crud1/update':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: UpdateScreenCrudDBOne(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: UpdateScreenCrudDBOne(
            args: const {},
          ),
        );
      case '/crud2/create':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: CreateScreenCrudDBTwo(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: CreateScreenCrudDBTwo(
            args: const {},
          ),
        );
      case '/crud2/read':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: ReadScreenCrudDBTwo(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: ReadScreenCrudDBTwo(
            args: const {},
          ),
        );
      
      case '/crud2/update':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: UpdateScreenCrudDBTwo(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: UpdateScreenCrudDBTwo(
            args: const {},
          ),
        );
      case '/crudApi/read':
        if (arguments is Map<String, dynamic>) {
          return PageTransition(
            duration: Duration.zero,
            type: PageTransitionType.fade,
            child: UserGroupList(
              args: arguments,
            ),
          );
        }
        return PageTransition(
          duration: Duration.zero,
          type: PageTransitionType.fade,
          child: UserGroupList(
            args: const {},
          ),
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
