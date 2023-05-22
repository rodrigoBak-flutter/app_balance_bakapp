import 'package:flutter/material.dart';

//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

class ChartSwichWidget extends StatelessWidget {
  const ChartSwichWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChart = Provider.of<UIProvider>(context).selectedChart;
    switch (currentChart) {
      case 'Grafico Circular':
        return const ChartPieWidget();
        case 'Grafico Lineal':
        return const ChartLineWidget();
        case 'Grafico Dispersion':
        return const ChartScatterPlotWidget();
      default: 
      return const ChartPieWidget();
    }
  }
}
