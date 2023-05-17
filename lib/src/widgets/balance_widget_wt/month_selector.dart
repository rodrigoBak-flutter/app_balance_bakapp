import 'package:flutter/material.dart';

//Providers
import 'package:provider/provider.dart';
import 'package:app_balances_bakapp/src/providers/providers.dart';

class MonthSelectorWidget extends StatelessWidget {
  const MonthSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UIProvider>(context, listen: false);

    int currentPage = Provider.of<UIProvider>(context).selectedMonth;
    PageController _controller;
    _controller =
        PageController(initialPage: currentPage, viewportFraction: 0.4);

    return SizedBox(
      height: size.height * 0.06,
      child: PageView(
        onPageChanged: (int i) => uiProvider.selectedMonth = i,
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        children: [
          _pageItems('Enero', 0, currentPage),
          _pageItems('Febrero', 1, currentPage),
          _pageItems('Marzo', 2, currentPage),
          _pageItems('Abril', 3, currentPage),
          _pageItems('Mayo', 4, currentPage),
          _pageItems('Junio', 5, currentPage),
          _pageItems('Julio', 6, currentPage),
          _pageItems('Agosto', 7, currentPage),
          _pageItems('Septiembre', 8, currentPage),
          _pageItems('Octubre', 9, currentPage),
          _pageItems('Noviembre', 10, currentPage),
          _pageItems('Diciembre', 11, currentPage),
        ],
      ),
    );
  }

  _pageItems(String name, int position, int currentPage) {
    var _aligment = Alignment.center;

    const selected = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    final unSelected = TextStyle(fontSize: 22, color: Colors.grey[700]);

    if (position == currentPage) {
      _aligment = Alignment.center;
    } else if (position > currentPage) {
      _aligment = Alignment.centerRight / 2;
    } else {
      _aligment = Alignment.centerLeft / 2;
    }

    return Align(
      alignment: _aligment,
      child: Text(
        name,
        style: position == currentPage ? selected : unSelected,
      ),
    );
  }
}
