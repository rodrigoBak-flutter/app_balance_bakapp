import 'package:flutter/material.dart';
import 'dart:math';

//Utils
import 'package:app_balances_bakapp/src/utils/math_operations.dart';
//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  //Controlador de la animacion
  final _scrollControler = ScrollController();
  double _offset = 0;

 // bool disableFAB = false; // Aqui declaro un booleano

  void _listener() {
    setState(() {
      _offset = _scrollControler.offset / 100;
      //  print(_max);
    });
  }

  @override
  void initState() {
    _scrollControler.addListener(_listener);
    _max;
    // TODO: implement initState
    super.initState();
  }

  double get _max => max(90 - _offset * 90, 0.0);

  @override
  void dispose() {
    _scrollControler.removeListener(_listener);
    _scrollControler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eList = context
        .watch<ExpensesProvider>()
        .eList; //tambien se puede llamar al provider asi:
    final etList = context
        .watch<ExpensesProvider>()
        .etList; // final etList = Provider.of<ExpensesProvider>(context).etList
    final month = context
            .watch<UIProvider>()
            .selectedMonth + // watch es que los lisen = true // read es que los lisen = false
        1; // Aqui mando llamar al provider month

    double totalExp = 0;
    double totalEt = 0;

    totalExp = getSumExp(eList);
    totalEt = getSumEnt(etList);

    ///// Aqui coloco la condicion ///////
    /*
    con esta condicion hago que cuando llegue a Diciembre no pueda cargar mas gastos

    if (month == 12) {
      disableFAB = true;
    } else {
      disableFAB = false;
    }
     */
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: // (disableFAB)
          // ? const Text('Ya no puede agregar mas ingresos, ni egresos')  :
          FlowButtonWidget(),
      body: CustomScrollView(
        controller: _scrollControler,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: size.height * 0.20,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MonthSelectorWidget(),
                  Text(
                    getBalance(eList, etList),
                    style: (totalExp > totalEt)
                        ? const TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)
                        : const TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Balance',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  children: [
                    const BackSheetWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: _max),
                      child: const FrontSheetWidget(),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
