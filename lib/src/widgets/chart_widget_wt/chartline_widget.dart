import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:charts_flutter_new/src/text_element.dart' as element;
import 'package:charts_flutter_new/src/text_style.dart' as style;

//Chart
import 'package:charts_flutter_new/flutter.dart' as charts;
//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

//Models
import 'package:app_balances_bakapp/src/models/expenses_model.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';

class ChartLineWidget extends StatelessWidget {
  static String? pointAmount;
  static String? pointDay;
  const ChartLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    
    ------------- Funciones grafico Lineal 1 ----------------------
    
    */
    var eList = Provider.of<ExpensesProvider>(context).eList;
    List<ExpensesModel> eModel = [];
    Map<int, dynamic> mapExp;

    //Ejemplo con Map
    mapExp = eList.fold({}, (Map<int, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expense;
      return map;
    });

    mapExp.forEach((key, value) {
      eModel.add(ExpensesModel(day: key, expense: value));
    });

    //Esta linea es para que comience del dia 0, con 0 gastos
    eModel.add(ExpensesModel(day: 0, expense: 0.0));
    //Esta linea lo que hace es ordenar los dias de mi grafico
    eModel.sort(((a, b) => a.day.compareTo(b.day)));

    List<charts.Series<ExpensesModel, num>> series = [
      charts.Series<ExpensesModel, num>(
        id: 'ExpensesDay',
        //El domainFn, es en el grafico el eje de las abscisas, las "X"
        domainFn: (v, i) => v.day,
        //El measureFn, es en el grafico el eje de las "Y"
        measureFn: (v, i) => v.expense,
        data: eModel,
        seriesColor: charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 77, 177, 80)),
      )
    ];

    /*
    
    ------------- Funciones grafico Lineal 2 ----------------------
    
    */
    List<double> perDayList;

    //Ejemplo con doubles

    //Con la formula daysInMonth, obtengo la cuantia de los dias del mes
    var currentMonth = Provider.of<UIProvider>(context).selectedMonth + 1;
    var currentDay = daysInMonth(currentMonth);
    perDayList = List.generate(currentDay + 1, (int i) {
      return eList
          .where((e) => e.day == (i))
          .map((e) => e.expense)
          .fold(0.0, (a, b) => a + b);
    });

    List<charts.Series<double, int>> series2 = [
      charts.Series<double, int>(
        id: 'ExpensesDay',
        //El domainFn, es en el grafico el eje de las abscisas, las "X"
        domainFn: (v, i) => i!,
        //El measureFn, es en el grafico el eje de las "Y"
        measureFn: (v, i) => v,
        //Colors de los graficos
        //seriesColor: charts.MaterialPalette.cyan.shadeDefault,
        seriesColor: charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 77, 177, 80)),
        radiusPxFn: (v, i) {
          if (v == 0.0) {
            return 0;
          }
          //Este return devuelve el tamaño de los puntos, probar en 5
          return 3;
        },
        data: perDayList,
      )
    ];

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: charts.LineChart(
          series,
          animate: true,
          defaultRenderer: charts.LineRendererConfig(
            includePoints: true,
            includeArea: true,
            areaOpacity: 0.2,
          ),

          //primaryMeasureAxis, configuracion del EJE "Y"
          primaryMeasureAxis: charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
                lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Colors.lightGreen[100]!)),
                labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Colors.lightGreen[500]!)),
                labelAnchor: charts.TickLabelAnchor.after,
                labelJustification: charts.TickLabelJustification.outside),
            //tickFormatterSpec, con esto determino la unidad de medida de mis "Y", en este caso en euros
            tickFormatterSpec:
                charts.BasicNumericTickFormatterSpec.fromNumberFormat(
                    NumberFormat.simpleCurrency(
                        decimalDigits: 0, locale: 'es')),
            tickProviderSpec:
                //Esto determina la cantidad de lineas que apareceran en mi eje carte
                const charts.BasicNumericTickProviderSpec(desiredTickCount: 8),
          ),
          //domainAxis ,configuracion del EJE "X"
          domainAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.StaticNumericTickProviderSpec([
            const charts.TickSpec(0, label: '0'),
            const charts.TickSpec(5, label: '5'),
            const charts.TickSpec(10, label: '10'),
            const charts.TickSpec(15, label: '15'),
            const charts.TickSpec(20, label: '20'),
            const charts.TickSpec(25, label: '25'),
            charts.TickSpec(currentDay, label: currentDay.toString()),
          ])),
          selectionModels: [
            charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection) {
                pointAmount = getAmountFormat(model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index)!
                    .toDouble());
                pointDay = model.selectedSeries[0]
                    .domainFn(model.selectedDatum[0].index)
                    .toString();
              }
            })
          ],
          //behaviors: Comportamiento del grafico
          behaviors: [
            charts.LinePointHighlighter(
              showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.nearest,
              symbolRenderer: SymbolRender(),
            ),
            charts.SelectNearest(
              eventTrigger: charts.SelectionTrigger.tapAndDrag,
            ),
          ],
        ),
      ),
    );
  }
}

//Es la clase que contiene el detalle de nuestros graficos
class SymbolRender extends charts.CircleSymbolRenderer {
  //Declaro una variable para definir el estilo del texto y ahorrar codigo
  var txtStyle = style.TextStyle();
  @override
  void paint(
    charts.ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int>? dashPattern,
    charts.Color? fillColor,
    charts.FillPatternType? fillPattern,
    charts.Color? strokeColor,
    double? strokeWidthPx,
  }) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      fillPattern: fillPattern,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );

    canvas.drawRect(
        //Los bounds determinan la posicion que va a tener nuestro rectangulo de detalles
        Rectangle(
          bounds.left - 25,
          bounds.top - 40,
          bounds.width + 88,
          bounds.height + 26,
        ),
        fill: charts.ColorUtil.fromDartColor(Colors.grey[900]!),
        stroke: charts.ColorUtil.fromDartColor(Colors.white),
        strokeWidthPx: 1);

    //Es mi variable declarada para darle un estilo propio al texto
    txtStyle.color = charts.MaterialPalette.white;
    txtStyle.fontSize = 12;

    //Propiedad que permite introducir texto en nuestro rectangulo de detalle
    canvas.drawText(
      element.TextElement(
          'Dia ${ChartLineWidget.pointDay} \n${ChartLineWidget.pointAmount}',
          style: txtStyle),
      (bounds.left - 1).round(),
      (bounds.top - 32).round(),
    );
  }
}
