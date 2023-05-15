import 'package:app_balances_bakapp/src/models/combined_model.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesDetailsScreen extends StatelessWidget {
  const ExpensesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.eList;
    final features = exProvider.fList;
    List<CombinedModel> cList = [];

    for (var x in expenses) {
      for (var y in features) {
        if (x.link == y.id) {
          cList.add(CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              amount: x.expense,
              comment: x.comment,
              ));
        }
      }
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Desglose de gastos'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                      leading: Icon(cList[i].icon.toIcon(),
                      color: cList[i].color.toColor(),
                      size: 35,),
                      title: Text(cList[i].category),
                      subtitle: Text(cList[i].comment),
                      trailing: Text(cList[i].amount.toStringAsFixed(2)),
                    ),
                childCount: cList.length),
          )
        ],
      ),
    );
  }
}
