import 'package:flutter/material.dart';

class OverlayBuilder extends StatefulWidget {
  final bool showOverlay;
  final Widget Function(BuildContext) overlayBuilder;
  final Widget child;

  OverlayBuilder({
    key,
    this.showOverlay: false,
    this.overlayBuilder,
    this.child,
  }) : super(key: key);

  @override
  _OverlayBuilderState createState() => _OverlayBuilderState();
}

class _OverlayBuilderState extends State<OverlayBuilder> {
  OverlayEntry overlayEntry;

  bool get isShowingOverlay => overlayEntry != null;

  @override
  void initState() {
    super.initState();

    if (widget.showOverlay) {
      showOverlay();
    }
  }

  @override
  void didUpdateWidget(OverlayBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    syncWidgetAndOverlay();
  }

  @override
  void reassemble() {
    super.reassemble();
    syncWidgetAndOverlay();
  }

  @override
  void dispose() {
    if (isShowingOverlay) {
      hideOverlay();
    }

    super.dispose();
  }

  void showOverlay() {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry (
        builder: widget.overlayBuilder,
      );
      addToOverlay(overlayEntry);
    } else {
      buildOverlay();
    }
  }

  void addToOverlay(OverlayEntry entry) async {
    final OverlayState overlay = Overlay.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => overlay.insert(entry));
  }

  void hideOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  void syncWidgetAndOverlay() {
    if (isShowingOverlay && !widget.showOverlay) {
      hideOverlay();
    } else if (!isShowingOverlay && widget.showOverlay) {
      showOverlay();
    }
  }

  void buildOverlay() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => overlayEntry?.markNeedsBuild());
  }

  @override
  Widget build(BuildContext context) {
    buildOverlay();

    return widget.child;
  }
}