import 'package:cinemaze/screens/auth/sign_in_screen.dart';
import 'package:cinemaze/screens/auth/user_info_screen.dart';
import 'package:cinemaze/screens/home_screen.dart';
import 'package:cinemaze/screens/initial_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'initial':
        return CupertinoPageRoute(builder: (_) => InitialScreen());
        break;
      case 'sign_in':
        return CupertinoPageRoute(builder: (_) => SignInScreen());
        break;
      case 'home':
        return CupertinoPageRoute(builder: (_) => HomeScreen());
        break;
      case 'user_info':
        return CupertinoPageRoute(builder: (_) => UserInfoScreen());
        break;
      default:
        return CupertinoPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
