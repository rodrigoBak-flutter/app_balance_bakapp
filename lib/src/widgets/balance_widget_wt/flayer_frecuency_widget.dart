import 'package:flutter/material.dart';
//Widgets
import 'package:app_balances_bakapp/src/widgets/widgets.dart';
//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

class FlayerFrecuencyWidget extends StatelessWidget {
  const FlayerFrecuencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.4,
          child: const ChartLineWidget(),
        ),
        GestureDetector(
          onTap: () {
            uiProvider.bnbIndex = 1;
            uiProvider.selectedChart = 'Grafico Lineal';
          },
          child: const Align(
            alignment: Alignment.bottomRight,
            widthFactor: 5.5,
            child: Text(
              'DETALLES',
              style: TextStyle(fontSize: 12.0, letterSpacing: 1.5),
            ),
          ),
        )
      ],
    );
  }
}
