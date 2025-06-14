import 'package:flutter/material.dart';
import 'package:wattsup/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners(); // notifie les widgets d’un changement
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
