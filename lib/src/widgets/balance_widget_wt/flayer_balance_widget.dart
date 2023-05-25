import 'package:flutter/material.dart';

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/math_operations.dart';

class FlayerBalanceWidget extends StatelessWidget {
  const FlayerBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eList = Provider.of<ExpensesProvider>(context).eList;
    final etList = Provider.of<ExpensesProvider>(context).etList;

    double totalExp = 0;
    double totalEt = 0;
    //double total = 0;

    totalExp = getSumExp(eList);
    totalEt = getSumEnt(etList);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Ingresos'),
                trailing: Text(
                  getAmountFormat(totalEt),
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Gastos'),
                trailing: Text(
                  getAmountFormat(totalExp),
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
                thickness: 2,
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Balance total'),
                trailing: Text(
                  getBalance(eList, etList),
                  style: (totalExp > totalEt)
                      ? const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)
                      : const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: size.height * 0.25,
            child: const ChartBarWidget(),
          ),
        ),
      ],
    );
  }
}
