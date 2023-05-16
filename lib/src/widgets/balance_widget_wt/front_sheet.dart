import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontSheetWidget extends StatelessWidget {
  const FrontSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  FlayerSkinWidget(
                      myTitle: 'Categoria de Gastos',
                      myWidget: FlayerCategoriesWidget()),
                  FlayerSkinWidget(
                      myTitle: 'Frecuencia de Gastos',
                      myWidget: SizedBox(height: 150)),
                  FlayerSkinWidget(
                      myTitle: 'Movimientos', myWidget: SizedBox(height: 150)),
                  FlayerSkinWidget(
                      myTitle: 'Balance General',
                      myWidget: SizedBox(height: 150)),
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
