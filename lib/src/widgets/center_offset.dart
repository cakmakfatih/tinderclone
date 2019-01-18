import 'package:flutter/widgets.dart';

class CenterOffset extends StatelessWidget {

  final Offset position;
  final Widget child;

  CenterOffset({
    key,
    this.position,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned (
      left: position.dx,
      top: position.dy,
      child: FractionalTranslation (
        translation: Offset(-0.5, -0.5),
        child: child,
      ),
    );
  }
}