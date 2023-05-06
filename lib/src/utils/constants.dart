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

  static CustomButton(Color decoration, Color border, String _text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: decoration,
            border: Border.all(
              color: border,
            ),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(_text),
        ),
      ),
    );
  }
}
