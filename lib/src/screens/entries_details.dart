import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesDetailsScreen extends StatefulWidget {
  const EntriesDetailsScreen({super.key});

  @override
  State<EntriesDetailsScreen> createState() => _EntriesDetailsScreenState();
}

class _EntriesDetailsScreenState extends State<EntriesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final etList = Provider.of<ExpensesProvider>(context).etList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Desglose de Ingresos'),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              return ListTile(
                title: Text(etList[i].entries.toString()),
                subtitle: Text(etList[i].comment.toString()),
                leading: Text(etList[i].day.toString() + '/' + etList[i].month.toString()+ '/' + etList[i].year.toString()),
              );
            }, childCount: etList.length),
          ),
        ],
      ),
    );
  }
}
