import 'package:flutter/material.dart';

class FlayerSkinWidget extends StatelessWidget {
  final String myTitle;
  final Widget myWidget;
  const FlayerSkinWidget({super.key, required this.myTitle, required this.myWidget});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 14,right: 14,bottom: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 14, bottom: 6),
            width: size.width,
            child: Text(
              myTitle,
              style: const TextStyle(fontSize: 18, letterSpacing: 1.5,fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(30)
            ),
            child: myWidget,
          ),
        ],
      ),
    );
  }
}
