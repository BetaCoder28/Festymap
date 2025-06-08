import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  late Box<User> _usersBox;

  AuthProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _usersBox = Hive.box<User>('users');
  }

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> register(String username, String email, String password) async {
    final newUser = User(
      username: username,
      email: email,
      password: password,
    );
    await _usersBox.put(email, newUser);
    _currentUser = newUser;
    notifyListeners();
  }

  bool login(String email, String password) {
    final user = _usersBox.get(email);
    if (user != null && user.password == password) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool isEmailRegistered(String email) {
    return _usersBox.containsKey(email);
  }
}
