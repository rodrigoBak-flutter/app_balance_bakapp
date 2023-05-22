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

class ChartPieFLayerWidget extends StatefulWidget {
  const ChartPieFLayerWidget({super.key});

  @override
  State<ChartPieFLayerWidget> createState() => _ChartPieWidgetState();
}

class _ChartPieWidgetState extends State<ChartPieFLayerWidget> {
  //Dejando el _index en -1 consigo que cuando ingreso a mi grafico no este nada preseleccionado
  int _index = 0;
  bool _animated = true;

  @override
  Widget build(BuildContext context) {
    var gList = Provider.of<ExpensesProvider>(context).groupItemsList;
    double totalOthers;

    if (_index >= gList.length) {
      _index = 0;
    }

    if (gList.length >= 6) {
      totalOthers =
          gList.sublist(0).map((e) => e.amount).fold(0.0, (a, b) => a + b);
      gList = gList.sublist(0, 5).toList();
      gList.add(CombinedModel(
        category: 'Otros..',
        amount: totalOthers,
        icon: 'otros',
        color: '#20634b'
      ));
    }

    var item = gList[_index];

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
                item.icon.toIcon(),
                color: item.color.toColor(),
                size: 40,
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                item.category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                getAmountFormat(item.amount),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
