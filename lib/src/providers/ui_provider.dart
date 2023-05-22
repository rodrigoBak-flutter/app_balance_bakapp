import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _bnbIndex = 0;

  int get bnbIndex => _bnbIndex;
  set bnbIndex(int i) {
    _bnbIndex = i;
    notifyListeners();
  }

  int _selectedMonth = DateTime.now().month - 1;

  int get selectedMonth => _selectedMonth;
  set selectedMonth(int i) {
    _selectedMonth = i;
    notifyListeners();
  }

  String _selectedChart = 'Grafico Circular';

  String get selectedChart => _selectedChart;
  set selectedChart(String s) {
    _selectedChart = s;
    notifyListeners();
  }
}
