import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cinemaze/providers/user_provider.dart';
import 'package:cinemaze/screens/auth/sign_in_screen.dart';
import 'package:cinemaze/screens/home_screen.dart';
import 'package:cinemaze/utils/authentication.dart';
import 'package:cinemaze/utils/custom_colors.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Widget nextScreen = SignInScreen();

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      disableNavigation: false,
      splash: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.spaceEvenly,
          direction: Axis.horizontal,
          verticalDirection: VerticalDirection.down,
          children: [
            Column(
              children: [
                Image.asset("assets/images/clapperboard.png", height: 100,),
                Padding(padding: EdgeInsets.only(top: 8), child: Text(
                  appName.toLowerCase(),
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: fontSizeLarge,
                    fontFamily: fontDisplay,
                  ),
                ),)
              ],
            )
          ],
        ),
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: CustomColors.firebaseNavy,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
    );
  }

  Future<void> checkAuth() async {
    User user = await Authentication.getUserData(context: context);
    if (user != null) {
      Provider.of<UserProvider>(context, listen: false).userData = user;
      setState(() {
        nextScreen = HomeScreen();
      });
    } else {
      setState(() {
        nextScreen = SignInScreen();
      });
    }
  }
}
