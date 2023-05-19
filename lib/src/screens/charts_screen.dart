import 'package:flutter/material.dart';

//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Utils
import 'package:app_balances_bakapp/src/utils/utils.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: const Text('Grafico'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.30,
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Selector'),
                      Expanded(
                        child: ChartLineWidget(),
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
          ],
        ));
  }
}
