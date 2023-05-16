import 'dart:math';

import 'package:flutter/material.dart';

//Provider
import 'package:app_balances_bakapp/src/providers/providers.dart';

//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  //Controlador de la animacion
  final _scrollControler = ScrollController();
  double _offset = 0;

  bool disableFAB = false; // Aqui declaro un booleano

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
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().eList;
    final month = context.watch<UIProvider>().selectedMonth +
        1; // Aqui mando llamar al provider month

    ///// Aqui coloco la condicion ///////
    if (month == 12) {
      disableFAB = true;
    } else {
      disableFAB = false;
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (disableFAB)
          ? const Text('Ya no puede agregar mas ingresos, ni egresos')
          : FlowButtonWidget(),
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
                children: const [
                  MonthSelectorWidget(),
                  Text(
                    '2,500',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                    ),
                  ),
                  Text(
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
