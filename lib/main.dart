import 'package:app_balances_bakapp/src/providers/ui_provider.dart';
import 'package:flutter/material.dart';

//Screens
import 'package:app_balances_bakapp/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => UIProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Este Widget le da inicio a la aplicacion.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[850],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[800],
          foregroundColor: Colors.white
        ),
      ),
      title: 'Balance',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
      },
    );
  }
}
