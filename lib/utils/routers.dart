import 'package:cinemaze/screens/auth/sign_in_screen.dart';
import 'package:cinemaze/screens/auth/user_info_screen.dart';
import 'package:cinemaze/screens/home_screen.dart';
import 'package:cinemaze/screens/initial_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'initial':
        return MaterialPageRoute(builder: (_) => InitialScreen());
        break;
      case 'sign_in':
        return MaterialPageRoute(builder: (_) => SignInScreen());
        break;
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case 'user_info':
        return MaterialPageRoute(builder: (_) => UserInfoScreen());
        break;
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
