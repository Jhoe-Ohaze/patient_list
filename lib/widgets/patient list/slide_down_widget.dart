import 'package:flutter/material.dart';

class SlideDownWidget extends StatelessWidget {
  final Widget child;
  const SlideDownWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation);
        return ClipRect(
            child: SlideTransition(position: offsetAnimation, child: child));
      },
      duration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}
