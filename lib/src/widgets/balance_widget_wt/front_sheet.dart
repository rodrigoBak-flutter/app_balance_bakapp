import 'package:flutter/material.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/constants.dart';

class FrontSheetWidget extends StatelessWidget {
  const FrontSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eList = Provider.of<ExpensesProvider>(context).eList;
    bool hasData = false;

    if (eList.isNotEmpty) {
      hasData = true;
    }
    return Container(
        decoration: Constants.sheetBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor),
        child: (hasData)
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const FlayerSkinWidget(
                      myTitle: 'Categoria de Gastos',
                      myWidget: FlayerCategoriesWidget()),
                  const FlayerSkinWidget(
                      myTitle: 'Frecuencia de Gastos',
                      myWidget: FlayerFrecuencyWidget()),
                  const FlayerSkinWidget(
                      myTitle: 'Movimientos',
                      myWidget: FlayerMovementsWidget()),
                  const FlayerSkinWidget(
                      myTitle: 'Balance General',
                      myWidget: FlayerBalanceWidget()),
                  SizedBox(
                    height: size.height * 0.10,
                  )
                ],
              )
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      'No tienes gastos este mes 😀',
                      maxLines: 1,
                      style: TextStyle(fontSize: 15, letterSpacing: 1.3),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(80),
                    child: Image.asset('assets/empty.png'),
                  ),
                ],
              ));
  }
}
