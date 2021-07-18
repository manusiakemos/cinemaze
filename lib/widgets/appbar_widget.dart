import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemaze/variables/variables.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Navigator.push(context, CupertinoPageRoute(builder: (context) => SignIn()));
          },
          icon: Icon(Icons.account_circle_outlined),
          color: textPrimary,
          iconSize: fontSizeExtraLarge,
        ),
        Text(
          appName.toLowerCase(),
          style: TextStyle(
            color: colorPrimary,
            fontSize: fontSizeLarge,
            fontFamily: fontDisplay,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: textPrimary,
          iconSize: fontSizeExtraLarge,
        ),
      ],
    );
  }
}
