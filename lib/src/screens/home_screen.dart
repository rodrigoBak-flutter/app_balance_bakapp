import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screens
import 'package:app_balances_bakapp/src/screens/screens.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/home_screen_wt/custom_navigation_bar.dart';
//Providers
import 'package:app_balances_bakapp/src/providers/ui_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final DateTime _date = DateTime.now();
    final currentIndex = uiProvider.bnbIndex;
    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
        exProvider.getEntriesByDate(currentMonth, _date.year);
        exProvider.getExpensesByDate(currentMonth, _date.year);
        exProvider.getAllFeatures();
        return const BalanceScreen();
      case 1:
        return const ChartsScreen();
      case 2:
        return const SettingScreen();
      default:
        return const BalanceScreen();
    }
  }
}
