import 'package:flutter/material.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;
  PageAnimationRoutes({required this.widget})
      : super(
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            widget,
          ) {
            animation = CurvedAnimation(
              parent: animation,
              //
              /*
                   Los Curves son las diferentes 
                   tipos de transiciones de pantalla    
                   */
              //
              curve: Curves.easeOutBack,
            );
            return ScaleTransition(
              alignment: const Alignment(0.8, 0.8),
              scale: animation,
              child: widget,
            );
          },
          pageBuilder: ((context, animation, secondaryAnimation) => widget),
        );
}
