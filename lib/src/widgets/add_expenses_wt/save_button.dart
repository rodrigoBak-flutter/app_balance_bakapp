import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Provider
import 'package:app_balances_bakapp/src/providers/providers.dart';
import 'package:provider/provider.dart';
//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/constants.dart';

class SaveButtonWidget extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;
  const SaveButtonWidget(
      {super.key, required this.cModel, required this.hasData});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UIProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //Condiciones por si el usuario guarda todo vacio
        if (cModel.amount != 0.0 && cModel.link != null) {
          (hasData)
              ? exProvider.updateExpenses(cModel)
              : exProvider.addNewExpenes(cModel);
          Fluttertoast.showToast(
              msg: (hasData) ? 'Gasto editado 👌' : 'Gasto agregado 👌',
              backgroundColor: Colors.green,
              textColor: Colors.white);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
        } else if (cModel.amount == 0.0) {
          Fluttertoast.showToast(
              msg: 'Debes agregar el monto de tu Gasto 😒',
              backgroundColor: Colors.yellow,
              textColor: Colors.black);
        } else {
          Fluttertoast.showToast(
              msg: 'Debes seleccionar una categoria 😒',
              backgroundColor: Colors.yellow,
              textColor: Colors.black);
        }
      },
      child: SizedBox(
        height: size.height * 0.1,
        width: size.width * 0.9,
        child: Constants.CustomButton(
          (hasData) ? Colors.green : Colors.green,
          Colors.white,
          (hasData) ? 'EDITAR' : 'GUARDAR',
        ),
      ),
    );
  }
}
