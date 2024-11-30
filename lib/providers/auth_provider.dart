import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  int? _userId;
  String? _username;

  bool get isLoggedIn => _isLoggedIn;
  int? userId() => _userId;
  String? get username => _username;

  void login(int userId, String username) {
    _isLoggedIn = true;
    _userId = userId;
    _username = username;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userId = null;
    _username = null;
    notifyListeners();
  }
}
