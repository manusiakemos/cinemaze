import 'package:cinemaze/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<UserProvider>(
            builder: (BuildContext context, UserProvider data, child){
              return InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "user_info");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(data.userData.photoURL, height: 35,),
                  ),
                ),
              );
            }
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
