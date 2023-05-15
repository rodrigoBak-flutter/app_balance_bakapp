import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesDetailsScreen extends StatefulWidget {
  const ExpensesDetailsScreen({super.key});

  @override
  State<ExpensesDetailsScreen> createState() => _ExpensesDetailsScreenState();
}

class _ExpensesDetailsScreenState extends State<ExpensesDetailsScreen> {
  //Controlador de la animacion
  final _scrollControler = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollControler.offset / 100;
      //  print(_offset);
    });
  }

  @override
  void initState() {
    _scrollControler.addListener(_listener);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final cList = exProvider.allItemsList;
    double totalExp = 0.0;
    //Funcion para sumar mis gastos
    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a + b);

    //Condicion para que mis gastos al hacer scroll no se vaya hacia la derecha
    if (_offset > 0.80) _offset = 0.8;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollControler,
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            title: Text('Desglose de gastos'),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset, 1),
                  child: Text(getAmountFormat(totalExp))),
              centerTitle: true,
              background: const Align(
                alignment: Alignment.bottomCenter,
                child: Text('Total'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 20,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              var item = cList[i];
              return ListTile(
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: item.color.toColor(),
                      size: 40,
                    ),
                    Positioned(
                      top: 16,
                      child: Text(item.day.toString()),
                    ),
                  ],
                ),
                title: Row(
                  children: [
                    Text(item.category),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      item.icon.toIcon(),
                      color: item.color.toColor(),
                    ),
                  ],
                ),
                subtitle: Text(item.comment),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getAmountFormat(item.amount),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              );
            }, childCount: cList.length),
          )
        ],
      ),
    );
  }
}
