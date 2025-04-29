import 'package:flutter/material.dart';
import 'animation_constants.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget child;
  final TransitionType transitionType;

  CustomPageTransition({
    required this.child,
    this.transitionType = TransitionType.fade,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(opacity: curved, child: child);
              case TransitionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                );
              case TransitionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                );
            }
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

enum TransitionType {
  fade,
  slideRight,
  slideUp,
}

class FadeSlideTransition extends StatelessWidget {
  final Widget child;
  final bool show;
  final Offset offset;
  final Duration duration;

  const FadeSlideTransition({
    Key? key,
    required this.child,
    this.show = true,
    this.offset = const Offset(0, 0.1),
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: show ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: duration,
        offset: show ? Offset.zero : offset,
        child: child,
      ),
    );
  }
}
