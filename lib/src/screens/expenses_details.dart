import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
//Model
import 'package:app_balances_bakapp/src/models/combined_model.dart';

class ExpensesDetailsScreen extends StatefulWidget {
  const ExpensesDetailsScreen({super.key});

  @override
  State<ExpensesDetailsScreen> createState() => _ExpensesDetailsScreenState();
}

class _ExpensesDetailsScreenState extends State<ExpensesDetailsScreen> {
  List<CombinedModel> cList = [];
  //Controlador de la animacion
  final _scrollControler = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollControler.offset / 100;
      //  print(_offset);
      //Condicion para que mis gastos al hacer scroll no se vaya hacia la derecha
      if (_offset > 0.80) _offset = 0.8;
    });
  }

  @override
  void initState() {
    _scrollControler.addListener(_listener);
    cList = Provider.of<ExpensesProvider>(context, listen: false).allItemsList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Recibo los argumentos de mis graficos
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?;
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UIProvider>(context, listen: false);
    cList = Provider.of<ExpensesProvider>(context, listen: true).allItemsList;

    double totalExp = 0.0;

    //Condicion para recibir los argumentos del dia seleccionado en mi pagina de graficos
    if (dataDay != null) {
      cList = cList.where((e) => e.day == dataDay).toList();
    }
    //Funcion para sumar mis gastos
    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a + b);

    cList.sort(
      (a, b) => b.day.compareTo(a.day),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollControler,
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            title: const Text('Desglose de gastos'),
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
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              var item = cList[i];
              return Slidable(
                key: ValueKey(item),
                startActionPane:
                    ActionPane(motion: const BehindMotion(), children: [
                  SlidableAction(
                    onPressed: (_) {
                      setState(() {
                        cList.removeAt(i);
                      });
                      exProvider.deleteExpenses(item.id!);
                      uiProvider.bnbIndex = 0;
                      Fluttertoast.showToast(
                          msg: 'Gasto eliminado 😉',
                          backgroundColor: Colors.red);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Eliminar',
                  ),
                  SlidableAction(
                    onPressed: (_) {
                      Navigator.pushNamed(context, 'add_expenses',
                          arguments: item);
                    },
                    backgroundColor: const Color.fromARGB(255, 186, 186, 5),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  ),
                ]),
                child: ListTile(
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
                ),
              );
            }, childCount: cList.length),
          )
        ],
      ),
    );
  }
}
