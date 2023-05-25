import 'package:flutter/material.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';

class FlayerCategoriesWidget extends StatelessWidget {
  const FlayerCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final exProvider = Provider.of<ExpensesProvider>(context);
    final uiProvider = Provider.of<UIProvider>(context, listen: true);
    final gList = exProvider.groupItemsList;
    List<CombinedModel> limintList = [];
    bool hasLimint = false;
    if (gList.length >= 6) {
      limintList = gList.sublist(0, 5);
      hasLimint = true;
    }
    if (limintList.length == 5) {
      limintList.add(
          CombinedModel(category: 'Otros..', icon: 'otros', color: '#20634b'));
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (hasLimint) ? limintList.length : gList.length,
                  itemBuilder: (_, i) {
                    var item = gList[i];
                    if (hasLimint == true) {
                      item = limintList[i];
                    }
                    return GestureDetector(
                      onTap: () {
                        if (item.category == 'Otros..') {
                          uiProvider.bnbIndex = 1;
                          uiProvider.selectedChart = 'Grafico Circular';
                        } else {
                          Navigator.pushNamed(context, 'categories_details',
                              arguments: item);
                        }
                      },
                      child: ListTile(
                        //dense y visualDensity, son propiedades para juntar/pegar nuestros elementos
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -2),
                        horizontalTitleGap: -5,
                        leading: Icon(
                          item.icon.toIcon(),
                          color: item.color.toColor(),
                        ),
                        title: Text(
                          item.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        // trailing: Text(getAmountFormat(item.amount)),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: size.height * 0.35,
                child: const ChartPieFLayerWidget(),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            uiProvider.bnbIndex = 1;
            uiProvider.selectedChart = 'Grafico Circular';
          },
          child: const Align(
            alignment: Alignment.bottomRight,
            widthFactor: 5.5,
            child: Text(
              'DETALLES',
              style: TextStyle(fontSize: 12.0, letterSpacing: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
