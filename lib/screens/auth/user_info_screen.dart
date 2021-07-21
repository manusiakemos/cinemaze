import 'package:cinemaze/providers/user_provider.dart';
import 'package:cinemaze/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Consumer<UserProvider>(
            builder: (BuildContext context, UserProvider data, child){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.userData.displayName),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: Text("Logout"),
                      onPressed: (){
                        Authentication.signOut(context: context);
                        Navigator.pushNamed(context, "sign_in");
                      },
                    ),
                  )
                ],
              );
            },
          )
      ),
    );
  }
}
