import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  CustomPageRoute({required Widget page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(1, 0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final slideAnimation = animation.drive(Tween(begin: begin, end: end).chain(CurveTween(curve: curve)));
            final fadeAnimation = animation.drive(Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: curve)));
            return SlideTransition(position: slideAnimation, child: FadeTransition(opacity: fadeAnimation, child: child));
          },
        );
}