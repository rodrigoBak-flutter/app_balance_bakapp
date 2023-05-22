import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerCategoryWidget extends StatelessWidget {
  const PerCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gList = Provider.of<ExpensesProvider>(context).groupItemsList;
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, i) {
        var item = gList[i];
        return ListTile(
          leading: Icon(
            item.icon.toIcon(),
            color: item.color.toColor(),
            size: 35,
          ),
          title: Text(item.category),
          trailing: Text(
            getAmountFormat(item.amount),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'categories_details', arguments: item);
          },
        );
      }, childCount: gList.length),
    );
  }
}
