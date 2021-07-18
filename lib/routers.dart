import 'package:cinemaze/screens/auth/sign_in_screen.dart';
import 'package:cinemaze/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case 'landing':
        return MaterialPageRoute(builder: (_) => SignInScreen());
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
