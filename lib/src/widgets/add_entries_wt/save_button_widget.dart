import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Utils
import 'package:app_balances_bakapp/src/utils/constants.dart';
//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Model
import 'package:app_balances_bakapp/src/models/combined_model.dart';

/*
  Pendiente agregarle el LINK para poder seleccionar una categoria de ingresos
 */

class SaveButtonEntriesWidget extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButtonEntriesWidget({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UIProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //Condiciones por si el usuario guarda todo vacio
        // if (cModel.amount != 0.0 && cModel.link != null) {
        if (cModel.amount != 0.0) {
          exProvider.addNewEntries(cModel);
          Fluttertoast.showToast(
              msg: 'Ingreso agregado 👌',
              backgroundColor: Colors.green,
              textColor: Colors.white);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
        } else if (cModel.amount == 0.0) {
          Fluttertoast.showToast(
              msg: 'Debes agregar el monto de tu Ingreso 😒',
              backgroundColor: Colors.yellow,
              textColor: Colors.black);
        } /*
          else {
          Fluttertoast.showToast(
              msg: 'Debes seleccionar una categoria 😒',
              backgroundColor: Colors.yellow,
              textColor: Colors.black);
        }
         */
      },
      child: SizedBox(
        height: size.height * 0.1,
        width: size.width * 0.9,
        child: Constants.CustomButton(
          Colors.green,
          Colors.white,
          'GUARDAR',
        ),
      ),
    );
  }
}
