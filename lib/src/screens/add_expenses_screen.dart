import 'package:flutter/material.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';
//Widgets
import '../widgets/widgets.dart';
//Model
import 'package:app_balances_bakapp/src/models/combined_model.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;

    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      /*
      onTap: () => FocusScope.of(context).unfocus(),
      Esta funcion permite minimozar mi Keyboar al tocar
      cualquier otro lugar que no sea mi cuadro de texto  
       */
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: (hasData)
                ? const Text('Editar Gasto')
                : const Text('Agregar Gasto'),
          ),
          body: Column(
            children: [
              BSNumKeyboardWidget(
                cModel: cModel,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: Constants.sheetBoxDecoration(
                      Theme.of(context).primaryColorDark),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DatePicketWidget(
                        cModel: cModel,
                      ),
                      BsCategoryWidget(cModel: cModel),
                      CommentBoxWidget(
                        cModel: cModel,
                      ),
                      Expanded(
                        child: Center(
                            child: SaveButtonWidget(
                          cModel: cModel,
                          hasData: hasData,
                        )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
