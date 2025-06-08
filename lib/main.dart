import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user_model.dart';
import 'models/event_model.dart';
import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrar adaptadores
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(EventAdapter());

  // Abrir cajas
  await Hive.openBox<User>('users');
  await Hive.openBox<Event>('events');

  runApp(FestyMapApp());
}

class FestyMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
        title: 'Festy Map',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
