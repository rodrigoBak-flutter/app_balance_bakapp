import 'package:flutter/material.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    return BottomNavigationBar(
      currentIndex: uiProvider.bnbIndex,
      onTap: (int i) => uiProvider.bnbIndex = i,
      elevation: 0.0,
      selectedItemColor: Theme.of(context).primaryColorDark,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).primaryColorDark,
      ),
      //unselectedItemColor: Theme.of(context).primaryColorDark,
      items: const [
        BottomNavigationBarItem(
          label: 'Balance',
          icon: Icon(
            Icons.account_balance_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Graficos',
          icon: Icon(
            Icons.bar_chart_outlined,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Configuraciones',
          icon: Icon(
            Icons.settings_outlined,
          ),
        ),
      ],
    );
  }
}
