import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';

class ChartScatterPlotWidget extends StatefulWidget {
  const ChartScatterPlotWidget({super.key});

  @override
  State<ChartScatterPlotWidget> createState() => _ChartScatterPlotWidgetState();
}

class _ChartScatterPlotWidgetState extends State<ChartScatterPlotWidget> {
  String catName = 'Total';
  double catAmmount = 0.0;
  int catDay = 0;
  int _index = -1;
  bool _animated = true;

  @override
  void initState() {
    super.initState();
    catAmmount = context
        .read<ExpensesProvider>()
        .eList
        .map((e) => e.expense)
        .fold(0.0, (a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    final cList = Provider.of<ExpensesProvider>(context).allItemsList;
    final currentMonth = Provider.of<UIProvider>(context).selectedMonth + 1;
    var currentDay = daysInMonth(currentMonth);

    var maxExp = cList.fold(0.0, (a, b) => a < b.amount ? b.amount : a);

    List<charts.Series<CombinedModel, num>> _series(int index) {
      return [
        charts.Series<CombinedModel, num>(
            id: 'Scatter',
            domainFn: (v, i) => v.day,
            measureFn: (v, i) => v.amount,
            labelAccessorFn: (v, i) => v.category,
            colorFn: (v, i) {
              var onTap = i == index;
              return (onTap)
                  ? charts.ColorUtil.fromDartColor(v.color.toColor()).darker
                  : charts.ColorUtil.fromDartColor(v.color.toColor());
            },
            radiusPxFn: (v, i) {
              var onTap = i == index;
              final bucket = v.amount / maxExp;
              if (bucket < 1 / 4) {
                return (onTap) ? 6 : 3;
              } else if (bucket < 2 / 4) {
                return (onTap) ? 12 : 6;
              } else {
                return (onTap) ? 15 : 9;
              }
            },
            data: cList)
      ];
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: -1,
          left: 39,
          child: Text('Dia : $catDay'),
        ),
        Positioned(
          top: -1,
          right: 40,
          child: Text('Categoria : $catName: ${getAmountFormat(catAmmount)}'),
        ),
        charts.ScatterPlotChart(
          _series(_index),
          animate: _animated,
          animationDuration: const Duration(microseconds: 500),
          primaryMeasureAxis: charts.NumericAxisSpec(
              tickFormatterSpec:
                  charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                NumberFormat.simpleCurrency(
                  locale: 'es',
                  decimalDigits: 0,
                ),
              ),
              tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  desiredTickCount: 6)),
          domainAxis: charts.NumericAxisSpec(
            tickProviderSpec: charts.StaticNumericTickProviderSpec([
              const charts.TickSpec(0, label: '0'),
              const charts.TickSpec(5, label: '5'),
              const charts.TickSpec(10, label: '10'),
              const charts.TickSpec(15, label: '15'),
              const charts.TickSpec(20, label: '20'),
              const charts.TickSpec(25, label: '25'),
              charts.TickSpec(currentDay, label: '$currentDay'),
            ]),
          ),
          selectionModels: [
            charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                setState(() {
                  _animated = false;
                  _index = model.selectedDatum[0].index!;
                  catName = model.selectedSeries[0]
                      .labelAccessorFn!(model.selectedDatum[0].index);
                  catAmmount = model.selectedSeries[0]
                      .measureFn(model.selectedDatum[0].index)!
                      .toDouble();
                  catDay = model.selectedSeries[0]
                      .domainFn(model.selectedDatum[0].index);
                });
              }
            }),
          ],
        )
      ],
    );
  }
}
