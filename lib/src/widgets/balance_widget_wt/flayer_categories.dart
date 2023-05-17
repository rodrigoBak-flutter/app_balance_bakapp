import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';

class FlayerCategoriesWidget extends StatelessWidget {
  const FlayerCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
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
    return Row(
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
                    Navigator.pushNamed(context, 'categories_details',
                        arguments: item);
                  },
                  child: ListTile(
                    //dense y visualDensity, son propiedades para juntar/pegar nuestros elementos
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -4),
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
          child: CircleColor(color: Colors.greenAccent, circleSize: 150),
        ),
      ],
    );
  }
}
