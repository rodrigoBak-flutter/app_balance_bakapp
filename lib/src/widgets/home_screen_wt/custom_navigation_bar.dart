import 'package:flutter/material.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final _inactiveColor = Theme.of(context).primaryColorDark;
    final _colorBar = Theme.of(context).primaryColorDark;
    final uiProvider = Provider.of<UIProvider>(context);
    return CustomAnimatedBottomBarWidget(
      containerHeight: 70,
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: uiProvider.bnbIndex,
      onItemSelected: (int i) => uiProvider.bnbIndex = i,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.account_balance_outlined),
          title: const Text('Balance'),
          activeColor: _colorBar,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.bar_chart_outlined),
          title: const Text('Graficos'),
          activeColor: _colorBar,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings_outlined),
          title: const Text('Configuraciones'),
          activeColor: _colorBar,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}




/*

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




 */
