import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier{
  User _userData;

  User get userData => _userData;

  set userData(User value) {
    _userData = value;
    notifyListeners();
  }
}