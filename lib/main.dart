import 'package:flutter/material.dart';

//Localizacion para el calendario
import 'package:flutter_localizations/flutter_localizations.dart';

//Privider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

//Screens
import 'package:app_balances_bakapp/src/screens/screens.dart';

/*
  Sacar de BalanceScreen la condicion de que en Diciembre ya no puedo cargar mas gatos e ingresos :)

 */

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
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.green),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green[800],
            foregroundColor: Colors.white,
          ),
          colorScheme: const ColorScheme.dark(primary: Colors.green),
          scaffoldBackgroundColor: Colors.grey[900],
          primaryColorDark: Colors.grey[850],
          dividerColor: Colors.grey),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'add_expenses': (_) => const AddExpensesScreen(),
        'categories_details': (_) => const CategoriesDetailScreen(),
      },
    );
  }
}
