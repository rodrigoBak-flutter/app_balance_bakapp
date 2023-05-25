import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/math_operations.dart';

class ChartBarWidget extends StatelessWidget {
  const ChartBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = Provider.of<ExpensesProvider>(context).eList;
    final etList = Provider.of<ExpensesProvider>(context).etList;

    double totalExp = 0;
    double totalEt = 0;

    totalExp = getSumExp(eList);
    totalEt = getSumEnt(etList);

    final data = [
      OrdinalSales('Ingresos', totalEt, Colors.green),
      OrdinalSales('Gastos', totalExp, Colors.red),
    ];

    List<charts.Series<OrdinalSales, String>> seriesList = [
      charts.Series<OrdinalSales, String>(
          id: 'Balance',
          domainFn: (v, i) => v.name,
          measureFn: (v, i) => v.ammount,
          colorFn: (v, i) => charts.ColorUtil.fromDartColor(v.color),
          data: data)
    ];

    return SizedBox(
      child: charts.BarChart(
        seriesList,
        defaultRenderer: charts.BarLaneRendererConfig(
            cornerStrategy: const charts.ConstCornerStrategy(50)),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
    );
  }
}

//Mini modelo para mostrar en mi Widget de balance los valores, colores de los graficos y sus respectivos nombres
class OrdinalSales {
  String name;
  double ammount;
  Color color;

  OrdinalSales(this.name, this.ammount, this.color);
}
