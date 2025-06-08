import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import 'auth_guard.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => LoginScreen(),
    '/register': (_) => RegisterScreen(),
    '/home': (context) => AuthGuard(
          builder: (_) => HomeScreen(),
        ),
  };
}
