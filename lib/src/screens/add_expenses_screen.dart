import 'package:flutter/material.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';
//Widgets
import '../widgets/widgets.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const BSNumKeyboardWidget(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Fecha 12/12/2023'),
                    Text('Seleccionar categoria'),
                    Text('Agregar comentario'),
                    Expanded(
                      child: Center(
                        child: Text('Btn Done'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
