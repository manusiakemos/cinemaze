
import 'package:cinemaze/providers/user_provider.dart';
import 'package:cinemaze/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  void initState()
  {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Cinemaze"),
        ),
      ),
    );
  }

  Future<void> checkAuth() async {
    debugPrint("checkAuth");
    bool _done = false;
    User user = await Authentication.getUserData(context: context);
    if(user != null){
      if(!_done){
        Provider.of<UserProvider>(context, listen: false).userData = user;
        setState(() {
          _done = true;
        });
        Navigator.pushNamed(context, "home");
      }
    }else{
      if(!_done){
        setState(() {
          _done = true;
        });
        Navigator.pushNamed(context, "sign_in");
      }
    }
  }
}

