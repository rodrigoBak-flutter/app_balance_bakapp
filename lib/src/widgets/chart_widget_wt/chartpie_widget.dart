import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';

class ChartPieWidget extends StatefulWidget {
  const ChartPieWidget({super.key});

  @override
  State<ChartPieWidget> createState() => _ChartPieWidgetState();
}

class _ChartPieWidgetState extends State<ChartPieWidget> {
  String catName = 'TOTAL';
  String catColor = '#388e3c';
  String catIcon = 'attach_money_outlined';
  double catAmmount = 0.0;
  double exTotal = 0.0;
  //Dejando el _index en -1 consigo que cuando ingreso a mi grafico no este nada preseleccionado
  int _index = -1;
  bool _animated = true;

  @override
  void initState() {
    catAmmount = Provider.of<ExpensesProvider>(context, listen: false)
        .eList
        .map((e) => e.expense)
        .fold(0.0, (a, b) => a + b);
    exTotal = Provider.of<ExpensesProvider>(context, listen: false)
        .eList
        .map((e) => e.expense)
        .fold(0.0, (a, b) => a + b);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gList = Provider.of<ExpensesProvider>(context).groupItemsList;

    List<charts.Series<CombinedModel, String>> _series(int index) {
      return [
        charts.Series<CombinedModel, String>(
            id: 'PieChart',
            domainFn: (v, i) => v.category,
            measureFn: (v, i) => v.amount,
            keyFn: (v, i) => v.icon,
            colorFn: (v, i) {
              /*
              Esta funcion me permite determinar que categoria selecciono el usuario
              y de esta manera oscurecerla
              */
              var onTap = i == index;
              if (onTap == false) {
                return charts.ColorUtil.fromDartColor(v.color.toColor());
              } else {
                return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
              }
            },
            labelAccessorFn: (v, i) =>
                '${v.category}\n${(v.amount * 100 / exTotal).toStringAsFixed(2)}%',
            outsideLabelStyleAccessorFn: (v, i) {
              var onTap = i == index;
              return charts.TextStyleSpec(
                  fontSize: (onTap) ? 14 : 8,
                  color: charts.ColorUtil.fromDartColor(
                      Theme.of(context).dividerColor));
            },
            data: gList)
      ];
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        charts.PieChart<String>(
          _series(_index),
          animate: _animated,
          animationDuration: const Duration(milliseconds: 600),
          defaultInteractions: true,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 45,
            strokeWidthPx: 0.0,
            /*
              Con esta propiedad obtengo el nombre de mis categorias
            arcRendererDecorators: [
              charts.ArcLabelDecorator(             
              )
            ]         
            */
            arcRendererDecorators: [
              charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.outside,
                labelPadding: 2,
                //showLeaderLines, propiedad para sacar las lineas de mi grafico, por defecto TRUE
                ///showLeaderLines: false,
                leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                    length: 12,
                    color: charts.MaterialPalette.white,
                    thickness: 1),
                /*
                outsideLabelStyleSpec: const charts.TextStyleSpec(
                  color: charts.MaterialPalette.white,
                  fontSize: 10,
                ),
                 */
              ),
            ],
          ),
          /*
            Con esta funcion consigo:
            la categoria,
            el monto total
          */
          selectionModels: [
            charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (model) {
                  if (model.hasDatumSelection) {
                    //Traigo el icono de la categoria
                    setState(() {
                      _animated = false;
                      _index = model.selectedDatum[0].index!;
                      catIcon = model.selectedSeries[0]
                          .keyFn!(model.selectedDatum[0].index)
                          .toString();
                      //Traigo el nombre de la categoria
                      catName = model.selectedSeries[0]
                          .domainFn(model.selectedDatum[0].index)
                          .toString();
                      //Traigo el monto de la categoria
                      catAmmount = model.selectedSeries[0]
                          .measureFn(model.selectedDatum[0].index)!
                          .toDouble();
                      //Traigo el color de la categoria
                      catColor = model.selectedSeries[0]
                          .colorFn!(model.selectedDatum[0].index)
                          .toString()
                          //Esta funcion reemplaza las letras "ff", en su posicion numero 6, por un String vacio,, asi recibo el color correcto
                          .replaceFirst(RegExp(r'ff'), '', 6);
                    });
                  }
                }),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Icon(
                catIcon.toIcon(),
                color: catColor.toColor(),
                size: 40,
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                catName,
                style: TextStyle(
                  color: catColor.toColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                getAmountFormat(catAmmount),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
