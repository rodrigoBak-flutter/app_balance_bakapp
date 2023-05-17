import 'package:flutter/material.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;
  final double ejex;
  final double ejey;
  PageAnimationRoutes(
      {required this.ejex, required this.ejey, required this.widget})
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
              alignment: Alignment(ejex, ejey),
              scale: animation,
              child: widget,
            );
          },
          pageBuilder: ((context, animation, secondaryAnimation) => widget),
        );
}
