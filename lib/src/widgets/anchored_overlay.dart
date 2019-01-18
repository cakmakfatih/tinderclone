import 'package:flutter/material.dart';
import 'overlay_builder.dart';

class AnchoredOverlay extends StatelessWidget {

  final bool showOverlay;
  final Widget Function(BuildContext, Rect anchorBounds, Offset anchor) overlayBuilder;
  final Widget child;

  AnchoredOverlay({
    key,
    this.showOverlay: false,
    this.overlayBuilder,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      child: LayoutBuilder (
        builder: (BuildContext context, BoxConstraints constraints) {
          return OverlayBuilder (
            showOverlay: showOverlay,
            overlayBuilder: (BuildContext overlayContext) {
              RenderBox box = context.findRenderObject() as RenderBox;
              final Offset topLeft = box.size.topLeft(box.localToGlobal(const Offset(0.0, 0.0)));
              final Offset bottomRight = box.size.bottomRight(box.localToGlobal(const Offset(0.0, 0.0)));
              final Rect anchorBounds = Rect.fromLTRB(
                topLeft.dx, 
                topLeft.dy, 
                bottomRight.dx, 
                bottomRight.dy
              );

              final anchorCenter = box.size.center(topLeft);

              return overlayBuilder(context, anchorBounds, anchorCenter);
            },
            child: child,
          );
        },
      ),
    );
  }

}