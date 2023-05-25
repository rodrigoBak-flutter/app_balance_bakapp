import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:app_balances_bakapp/src/providers/shared_preference.dart';
import 'package:provider/provider.dart';

class DarkModeSwichWidget extends StatefulWidget {
  const DarkModeSwichWidget({super.key});

  @override
  State<DarkModeSwichWidget> createState() => _DarkModeSwichWidgetState();
}

class _DarkModeSwichWidgetState extends State<DarkModeSwichWidget> {
  bool _darkMode = false;
  final preference = UserPrefence();

  @override
  void initState() {
    super.initState();
    _darkMode = preference.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    final swapTheme = Provider.of<ThemeProvider>(context);
    return SwitchListTile(
      value: _darkMode,
      title: const Text(
        'Modo Oscuro',
        style: TextStyle(fontSize: 14),
      ),
      subtitle: const Text('El modo oscuro ayuda a ahorrar bateria'),
      onChanged: (value) {
        setState(() {
          _darkMode = value;
          preference.darkMode = value;
          swapTheme.swapTheme();
        });
      },
    );
  }
}
