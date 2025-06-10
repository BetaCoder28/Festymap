import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'models/user_model.dart';
import 'models/event_model.dart';
import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'routes/app_routes.dart';
import 'services/notification_service.dart';
import 'screens/event_detail_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // Asegurar que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Solicitar permisos de notificación (Android 13+)
  await Permission.notification.request();

  // Inicializar Hive
  await Hive.initFlutter();

  // Registrar adaptadores
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(EventAdapter());

  // Abrir cajas de almacenamiento
  await Hive.openBox<User>('users');
  await Hive.openBox<Event>('events');

  // Inicializar el servicio de notificaciones
  await NotificationService().initialize();

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
        navigatorKey: NotificationService.navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // Inglés
          Locale('es'), // Español, puedes agregar más si necesitas
        ],
        onGenerateRoute: (settings) {
          if (settings.name == '/event_detail') {
            final eventId = settings.arguments as String;
            final eventProvider =
                Provider.of<EventProvider>(context, listen: false);
            final event = eventProvider.eventos.firstWhere(
              (e) => e.id == eventId,
              orElse: () => Event(
                id: '',
                titulo: 'Evento no encontrado',
                lugar: '',
                imagen: '',
                calle: '',
                numero: '',
                ciudad: '',
                estado: '',
                fecha: '',
                hora: '',
                latitud: 0,
                longitud: 0,
              ),
            );
            return MaterialPageRoute(
              builder: (context) => EventDetailScreen(event: event),
            );
          }
          return null;
        },
      ),
    );
  }
}
