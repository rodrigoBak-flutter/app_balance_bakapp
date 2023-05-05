import 'package:flutter/widgets.dart';

class Constants {
  static sheetBoxDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }
}
