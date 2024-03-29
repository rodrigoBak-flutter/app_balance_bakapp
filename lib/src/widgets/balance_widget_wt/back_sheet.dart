import 'package:flutter/material.dart';
//Screens
import 'package:app_balances_bakapp/src/screens/screens.dart';
//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:app_balances_bakapp/src/utils/utils.dart';

class BackSheetWidget extends StatelessWidget {
  const BackSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eList = Provider.of<ExpensesProvider>(context).eList;
    final etList = Provider.of<ExpensesProvider>(context).etList;
    _headers(String name, String amount, Color color) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, bottom: 5.0),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 1.5,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return Container(
      height: size.height * 0.25,
      decoration:
          Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageAnimationRoutes(
                    widget: const EntriesDetailsScreen(),
                    ejex: -0.5,
                    ejey: -0.5,
                  ));
            },
            child: _headers(
                'Ingresos',
                getAmountFormat(
                  getSumEnt(etList),
                ),
                Colors.green),
          ),
          const VerticalDivider(
            thickness: 2.0,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageAnimationRoutes(
                      widget: const ExpensesDetailsScreen(),
                      ejex: 0.5,
                      ejey: -0.5,
                    ));
              },
              child: _headers(
                  'Gastos',
                  getAmountFormat(
                    getSumExp(eList),
                  ),
                  Colors.red)),
        ],
      ),
    );
  }
}
