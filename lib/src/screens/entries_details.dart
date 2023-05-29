import 'package:app_balances_bakapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Models
import 'package:app_balances_bakapp/src/models/models.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/math_operations.dart';

class EntriesDetailsScreen extends StatefulWidget {
  const EntriesDetailsScreen({super.key});

  @override
  State<EntriesDetailsScreen> createState() => _EntriesDetailsScreenState();
}

class _EntriesDetailsScreenState extends State<EntriesDetailsScreen> {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Recibo los argumentos de mis graficos
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?;
    final etList = Provider.of<ExpensesProvider>(context).etList;
    final etProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UIProvider>(context, listen: false);

    double totalEnt = 0.0;
    //Funcion para sumar mis ingresos
    totalEnt = getSumEnt(etList);

    //Condicion para recibir los argumentos del dia seleccionado en mi pagina de graficos
    if (dataDay != null) {
      cList = cList.where((e) => e.day == dataDay).toList();
    }

    etList.sort(
      (a, b) => b.day.compareTo(a.day),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            title: const Text('Desglose de Ingresos'),
            centerTitle: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment(_offset, 1),
                child: Text(
                  getAmountFormat(totalEnt),
                  style: TextStyle(
                      color: Theme.of(context).appBarTheme.foregroundColor),
                ),
              ),
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
              var item = etList[i];
              return Slidable(
                key: ValueKey(item),
                startActionPane:
                    ActionPane(motion: const BehindMotion(), children: [
                  SlidableAction(
                    onPressed: (_) {
                      setState(() {
                        etList.removeAt(i);
                      });
                      etProvider.deleteEntries(item.id!);
                      uiProvider.bnbIndex = 0;

                      Fluttertoast.showToast(
                          msg: 'Ingreso eliminado 😉',
                          backgroundColor: Colors.red);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Eliminar',
                  ),
                  /*
                    SlidableAction(
                    onPressed: (_) {
                      Navigator.pushNamed(context, 'add_entries',
                          arguments: item);
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  ),
                   */
                ]),
                child: ListTile(
                  leading: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.green,
                        size: 40,
                      ),
                      Positioned(
                        top: 16,
                        child: Text(item.day.toString()),
                      ),
                    ],
                  ),
                  title: Text(item.comment),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        getAmountFormat(item.entries),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${(100 * item.entries / totalEnt).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: etList.length),
          ),
        ],
      ),
    );
  }
}
