import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/expenses_provider.dart';
//Models
import 'package:app_balances_bakapp/src/models/combined_model.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils_colors.dart';
import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:app_balances_bakapp/src/utils/math_operations.dart';

class CategoriesDetailScreen extends StatefulWidget {
  const CategoriesDetailScreen({super.key});

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var cList = Provider.of<ExpensesProvider>(context).allItemsList;
    var eList = Provider.of<ExpensesProvider>(context).eList;
    var etList = Provider.of<ExpensesProvider>(context).etList;
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    var totalEt = getAmountFormat(getSumEnt(etList));
    var totalEx = getAmountFormat(getSumExp(eList));

    cList = cList.where((e) => e.category == cModel!.category).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            title: Text(cModel!.category),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    getAmountFormat(cModel.amount),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PercentCircularWiget(
                              percent: cModel.amount / getSumEnt(etList),
                              radius: 70,
                              color: Colors.lightBlue,
                              arcType: ArcType.HALF),
                          Text(
                            'Absorbe de tus\nIngresos: $totalEt',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PercentCircularWiget(
                              percent: cModel.amount / getSumExp(eList),
                              radius: 70,
                              color: Colors.red,
                              arcType: ArcType.HALF),
                          Text(
                            'Absorbe de tus\nGastos: $totalEx',
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              height: size.height * 0.04,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              var item = cList[i];

              return ListTile(
                leading: Stack(alignment: Alignment.center, children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 40,
                  ),
                  Positioned(top: 16, child: Text(item.day.toString()))
                ]),
                title: PercentLinearWidget(
                  percent: item.amount / cModel.amount,
                  color: item.color.toColor(),
                ),
                trailing: Text(
                  getAmountFormat(item.amount),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              );
            }, childCount: cList.length),
          )
        ],
      ),
    );
  }
}
