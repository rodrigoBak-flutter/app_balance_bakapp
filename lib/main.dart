import 'package:flutter/material.dart';

//Localizacion para el calendario
import 'package:flutter_localizations/flutter_localizations.dart';

//Privider
import 'package:app_balances_bakapp/src/providers/providers.dart';

//Screens
import 'package:app_balances_bakapp/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Este Widget le da inicio a la aplicacion.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balance',
      //Idioma que se va a desplegar el calendario
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        // ignore: prefer_const_constructors
        Locale('es', 'ES'), // Español
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[800],
          foregroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(primary: Colors.green),
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[850],
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
      },
    );
  }
}
