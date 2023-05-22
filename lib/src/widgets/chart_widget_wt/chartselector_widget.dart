import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Provider
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

class ChartSelectorWidget extends StatefulWidget {
  const ChartSelectorWidget({super.key});

  @override
  State<ChartSelectorWidget> createState() => _ChartSelectorWidgetState();
}

class _ChartSelectorWidgetState extends State<ChartSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final currentChart = Provider.of<UIProvider>(context).selectedChart;
    final uiProvider = Provider.of<UIProvider>(context, listen: true);
    var _widget = <Widget>[];

    Map<String, IconData> typeChart = {
      'Grafico Lineal': Icons.show_chart_outlined,
      'Grafico Circular': CupertinoIcons.chart_pie,
      'Grafico Dispersion': Icons.bubble_chart,
    };

    typeChart.forEach((name, icon) {
      _widget.add(GestureDetector(
        onTap: () => setState(() {
          uiProvider.selectedChart = name;
          // print(uiProvider.selectedChart = name);
        }),
        child: BubleTab(
          icon: icon,
          selected: currentChart == name,
        ),
      ));
    });
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Wrap(
        spacing: 10,
        children: _widget,
      ),
    );
  }
}

class BubleTab extends StatelessWidget {
  final bool selected;
  final IconData icon;
  const BubleTab({super.key, required this.selected, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          color: (selected) ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(25)),
      child: Icon(icon),
    );
  }
}
