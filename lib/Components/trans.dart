import 'package:flutter/material.dart';

void navigateWithCustomAnimation(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final curveTween = CurveTween(curve: curve);
        final scaleTween = Tween<double>(begin: 0.4, end: 1.0).chain(curveTween);
        final opacityTween = Tween<double>(begin: 0.0, end: 1.0).chain(curveTween);

        return FadeTransition(
          opacity: animation.drive(opacityTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    ),
  );
}
