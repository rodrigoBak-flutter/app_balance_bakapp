import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*

---- En esta pagina configuro los colores de mi modo oscuro y mi modo claro -----

*/

class ThemeProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;

  ThemeData dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
      backgroundColor: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[800],
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.green,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColorDark: Colors.grey[800],
    dividerColor: Colors.white,
  );

  ThemeData light = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
      backgroundColor: Colors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColorDark: const Color.fromARGB(255, 203, 244, 198),
    dividerColor: Colors.black,
  );

  ThemeProvider(bool isDark) {
    //Funcion booleana, si es verdadero recibo mi tema dark, de lo contrario mi tema light
    _selectedTheme = (isDark) ? dark : light;
  }

  Future<void> swapTheme() async {
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      Fluttertoast.showToast(msg: 'Modo claro Activado 😎',backgroundColor: Colors.green);
    } else {
      _selectedTheme = dark;
      Fluttertoast.showToast(msg: 'Modo oscuro Activado 😉',backgroundColor: Colors.green);
    }
    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
}
