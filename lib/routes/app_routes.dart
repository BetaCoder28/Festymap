import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/create_event_screen.dart';
import '../screens/event_created_screen.dart';
import '../screens/event_detail_screen.dart';
import 'auth_guard.dart';
import 'package:festymap/models/event_model.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => LoginScreen(),
    '/register': (_) => RegisterScreen(),
    '/home': (context) => AuthGuard(builder: (_) => HomeScreen()),
    '/create_event': (context) =>
        AuthGuard(builder: (_) => CrearEventoScreen()),
    '/event_created': (context) =>
        AuthGuard(builder: (_) => EventoCreadoScreen()),
    '/event_detail': (context) => AuthGuard(builder: (_) {
          final event = ModalRoute.of(context)!.settings.arguments as Event;
          return EventDetailScreen(event: event);
        }),
  };
}
