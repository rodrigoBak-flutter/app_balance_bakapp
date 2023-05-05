import 'package:flutter/material.dart';

class FabVerticalDelegate extends FlowDelegate {
  final AnimationController animation;
  FabVerticalDelegate({required this.animation}) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    const bottonSize = 76;
    const bottonRadius = bottonSize / 2;
    const bottonMargin = 2;

    final positionX = context.size.width - bottonSize;
    final positionY = context.size.height - bottonSize;

    final lastFabIndex = context.childCount - 1;

    for (int i = lastFabIndex; i >= 0; i--) {
      final y = positionY - ((bottonSize + bottonMargin) * i * animation.value);

      final size = (i != 0) ? animation.value : 1.0;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(positionX, y, 0)
          ..translate(bottonRadius, bottonRadius)
          ..scale(size)
          ..translate(-bottonRadius, -bottonRadius),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}