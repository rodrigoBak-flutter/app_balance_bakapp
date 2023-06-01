import 'package:flutter/material.dart';

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChart = Provider.of<UIProvider>(context).selectedChart;
    bool _isPerDay = false;

    //Condicion que me permite elegir el listado en funcion del grafico que selecciono
    if (currentChart == 'Grafico Lineal' ||
        currentChart == 'Grafico Dispersion') {
      _isPerDay = true;
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: Text(currentChart),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.45,
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ChartSelectorWidget(),
                      Expanded(
                        child: ChartSwichWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: size.height * 0.045,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  decoration: Constants.sheetBoxDecoration(
                      Theme.of(context).primaryColorDark),
                ),
              ),
            ),
            (_isPerDay) ? const PerDayListWidget() : const PerCategoryWidget()
          ],
        ));
  }
}
