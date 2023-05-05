import 'package:app_balances_bakapp/src/utils/constants.dart';
import 'package:flutter/material.dart';

class FrontSheetWidget extends StatelessWidget {
  const FrontSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var _list = List.generate(
      10,
      (i) => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );

    return Container(
      decoration: Constants.sheetBoxDecoration(
          Theme.of(context).scaffoldBackgroundColor),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _list,
      ),
    );
  }
}
