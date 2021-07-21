import 'package:flutter/material.dart';

enum AuthState { SignIn, Logout }

class BaseModel extends ChangeNotifier {

  AuthState _authState;

  AuthState get authState => _authState;

  setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }
}
