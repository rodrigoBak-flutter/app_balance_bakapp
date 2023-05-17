import 'package:flutter/material.dart';

//Widget
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Model
import 'package:app_balances_bakapp/src/models/features_model.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';

class AdminCategoryWidget extends StatelessWidget {
  const AdminCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fList = Provider.of<ExpensesProvider>(context).fList;
    return ListView.builder(
      itemCount: fList.length,
      itemBuilder: (_, i) {
        var item = fList[i];
        return ListTile(
          leading: Icon(
            item.icon.toIcon(),
            size: 35,
            color: item.color.toColor(),
          ),
          title: Text(item.category),
          trailing: const Icon(
            Icons.edit,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
            _createCategory(context, item);
          },
        );
      },
    );
  }

  _createCategory(BuildContext context, FeaturesModel fModel) {
    var features = FeaturesModel(
      id: fModel.id,
      category: fModel.category,
      color: fModel.color,
      icon: fModel.icon,
    );
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      context: context,
      builder: (_) => CreateCategoryWidget(fModel: features),
    );
  }
}
