import 'package:flutter/material.dart';

/*

---- En esta pagina configuro los colores de mi modo oscuro y mi modo claro -----

*/

class ThemeProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;

  ThemeData dark = ThemeData.dark().copyWith(
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
    dividerColor: Colors.white,
  );

  ThemeData light = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.green,
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[800],
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.lightBlue[200],
    primaryColorDark: Colors.lightBlue[500],
    dividerColor: Colors.black,
  );

  ThemeProvider(bool isDark) {
    //Funcion booleana, si es verdadero recibo mi tema dark, de lo contrario mi tema light
    _selectedTheme = (isDark) ? dark : light;
  }

  Future<void> swapTheme() async {
    if (_selectedTheme == dark) {
      _selectedTheme = light;
    } else {
      _selectedTheme = dark;
    }
    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
}
