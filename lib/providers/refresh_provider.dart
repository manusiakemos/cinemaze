import 'package:flutter/foundation.dart';

class RefreshProvider with ChangeNotifier{
  bool _refresh = false;

  bool get refresh => _refresh;

  set refresh(bool value) {
    _refresh = value;
    notifyListeners();
  }

  void refreshPage() {
    _refresh = !_refresh;
    notifyListeners();
  }
}