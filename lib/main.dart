import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;

//Preferencias del usuario
import 'package:app_balances_bakapp/src/providers/shared_preference.dart';
//Localizacion para el calendario
import 'package:flutter_localizations/flutter_localizations.dart';

//Privider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:app_balances_bakapp/src/providers/local_notification.dart';

//Rutas
import 'package:app_balances_bakapp/src/routes/routes.dart';

/*
  Sacar de BalanceScreen la condicion de que en Diciembre ya no puedo cargar mas gatos e ingresos :)

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  final preference = UserPrefence();
  final notification = LocalNotification();

  await preference.initPreference();
  await notification.initialize();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider(preference.darkMode)),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Este Widget le da inicio a la aplicacion.

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
        title: 'Balance',
        //Idioma que se va a desplegar el calendario
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          // ignore: prefer_const_constructors
          Locale('es', 'ES'), // Español
        ],
        debugShowCheckedModeBanner: false,
        theme: value.getTheme(),
        initialRoute: 'home',
        routes: appRoutes,
      );
    });
  }
}
