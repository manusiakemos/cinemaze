import 'package:cinemaze/providers/user_provider.dart';
import 'package:cinemaze/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    String initialRoute = "initial";
    return ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          initialRoute: initialRoute,
          onGenerateRoute: Routers.generateRoute,
        ));
  }
}
