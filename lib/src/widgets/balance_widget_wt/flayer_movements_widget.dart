import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

//Providers

class FlayerMovementsWidget extends StatelessWidget {
  const FlayerMovementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = Provider.of<ExpensesProvider>(context).eList;
    final etList = Provider.of<ExpensesProvider>(context).etList;

    double _totalExp = 0;
    double _totalEt = 0;

    _totalExp = getSumExp(eList);
    _totalEt = getSumEnt(etList);

    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: PercentCircularWiget(
            percent: _totalExp / _totalEt,
            radius: 70,
            color: Colors.red,
            arcType: ArcType.FULL,
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: size.height * 0.20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Gastos realizados',style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,letterSpacing: 1.3),),
                Text(
                  getAmountFormat(
                    _totalExp,
                  ),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,letterSpacing: 1.3),
                ),
                Text('Absorbe un ${(_totalExp / _totalEt * 100).toStringAsFixed(2)}% de tus ingresos',style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold,letterSpacing: 1.3),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
