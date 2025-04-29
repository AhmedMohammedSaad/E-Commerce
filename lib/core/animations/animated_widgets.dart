import 'package:flutter/material.dart';
import 'animation_constants.dart';

class AnimatedScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Duration duration;
  final Curve curve;

  const AnimatedScaleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();
}

class _AnimatedScaleButtonState extends State<AnimatedScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: AnimationConstants.buttonPressedScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
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
