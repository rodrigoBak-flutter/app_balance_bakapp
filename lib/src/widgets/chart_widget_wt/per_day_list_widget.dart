import 'package:app_balances_bakapp/src/models/models.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerDayListWidget extends StatelessWidget {
  const PerDayListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = Provider.of<ExpensesProvider>(context).eList;
    List<CombinedModel> _perDay = [];
    Map<dynamic, dynamic> _perDayMap;
    _perDayMap = eList.fold({}, (Map<dynamic, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0;
      }
      map[exp.day] += exp.expense;
      return map;
    });

    _perDayMap.forEach(
      (day, exp) {
        _perDay.add(CombinedModel(
          day: day,
          amount: exp,
        ));
      },
    );
    //Ordenar el listado por dia, de mayor a menor
    _perDay.sort((a, b) => b.day.compareTo(a.day));
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, i) {
        var item = _perDay[i];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              'expenses_details',
              arguments: item.day,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Dia'),
                  const Divider(),
                  Text(
                    item.day.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  const Divider(),
                  Text(
                    getAmountFormat(item.amount),
                    // style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: _perDay.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 12),
    );
  }
}
