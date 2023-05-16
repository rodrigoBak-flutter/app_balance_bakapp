import 'package:app_balances_bakapp/src/screens/entries_details.dart';
import 'package:app_balances_bakapp/src/screens/expenses_details.dart';
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';

class BackSheetWidget extends StatelessWidget {
  const BackSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 20, letterSpacing: 1.5, color: color),
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
              child: _headers('Ingresos', '3,500.00', Colors.green)),
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
              child: _headers('Gastos', '1,500.00', Colors.red)),
        ],
      ),
    );
  }
}
