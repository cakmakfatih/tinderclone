import 'package:flutter/material.dart';
import '../models/decision.dart';
import '../models/slide_direction.dart';
import 'anchored_overlay.dart';
import 'center_offset.dart';
import 'dart:math' show pi, Random;

class DraggableCard extends StatefulWidget {

  final Widget card;
  final bool isDraggable;
  final SlideDirection slideTo;
  final Function(double distance) onSlideUpdated;
  final Function(SlideDirection direction) onSlideOutCompleted;

  DraggableCard({
    this.card,
    this.isDraggable: true,
    this.slideTo,
    this.onSlideUpdated,
    this.onSlideOutCompleted,
  });

  @override
  _DraggableCardState createState() => _DraggableCardState();

}

class _DraggableCardState extends State<DraggableCard> with TickerProviderStateMixin {

  Decision decision;
  GlobalKey profileCardKey = GlobalKey(debugLabel: 'profile_card_key');
  Offset cardOffset = Offset(0.0, 0.0);
  Offset dragStart;
  Offset dragPosition;
  Offset slideBackStart;
  SlideDirection slideOutDirection;
  AnimationController slideBackAnimation;
  Tween<Offset> slideOutTween;
  AnimationController slideOutAnimation;

  @override
  void initState() {
    super.initState();

    slideBackAnimation = AnimationController (
      duration: Duration(milliseconds: 1000),
      vsync: this
    )
    ..addListener(() => setState(() {
      cardOffset = Offset.lerp (
        slideBackStart,
        Offset(0.0, 0.0),
        Curves.elasticOut.transform(slideBackAnimation.value)
      );

      if(widget.onSlideUpdated != null) {
        widget.onSlideUpdated(cardOffset.distance);
      }
    }))
    ..addStatusListener((AnimationStatus status) {
      if(status == AnimationStatus.completed) {
        setState(() {
          dragStart = null;
          slideBackStart = null;
          dragPosition = null;
        });
      }
    });

    slideOutAnimation = AnimationController (
      duration: Duration(milliseconds: 500),
      vsync: this
    )
    ..addListener(() {
      setState(() {
        cardOffset = slideOutTween.evaluate(slideOutAnimation);

        if(widget.onSlideUpdated != null) {
          widget.onSlideUpdated(cardOffset.distance);
        }
      });
    })
    ..addStatusListener((AnimationStatus status) {
      if(status == AnimationStatus.completed) {
        setState(() {
          dragStart = null;
          dragPosition = null;
          slideOutTween = null;

          if(widget.onSlideOutCompleted != null) {
            widget.onSlideOutCompleted(slideOutDirection);
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(DraggableCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.card.key != oldWidget.card.key) {
      cardOffset = Offset(0.0, 0.0);
    }

    if(oldWidget.slideTo == null && widget.slideTo != null) {
      switch(widget.slideTo) {
        case SlideDirection.LEFT:
          _slideLeft();
          break;
        case SlideDirection.RIGHT:
          _slideRight();
          break;
        case SlideDirection.UP:
          _slideUp();
          break;
      }
    }
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    dragStart = details.globalPosition;

    if(slideBackAnimation.isAnimating) {
      slideBackAnimation.stop(canceled: true);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragPosition = details.globalPosition;
      cardOffset = dragPosition - dragStart;

      if(widget.onSlideUpdated != null) {
        widget.onSlideUpdated(cardOffset.distance);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final Offset dragVector = cardOffset / cardOffset.distance;

    final bool isInLeftRegion = (cardOffset.dx / context.size.width) < -0.45;
    final bool isInRightRegion = (cardOffset.dx / context.size.width) > 0.45;
    final bool isInTopRegion = (cardOffset.dy / context.size.height) < -0.40;

    setState(() {
      if(isInLeftRegion || isInRightRegion) {
        slideOutTween = Tween(begin: cardOffset, end: dragVector * (2 * context.size.width));
        slideOutAnimation.forward(from: 0.0);

        slideOutDirection = isInLeftRegion ? SlideDirection.LEFT : SlideDirection.RIGHT;
      }
      else if(isInTopRegion) {
        slideOutTween = Tween(begin: cardOffset, end: dragVector * (2 * context.size.height));
        slideOutAnimation.forward(from: 0.0);

        slideOutDirection = SlideDirection.UP;
      }
      else {
        slideBackStart = cardOffset;
        slideBackAnimation.forward(from: 0.0);
      }
    });
  }

  double _rotation(Rect dragBounds) {
    if(dragStart != null) {
      final rotationCornerMultiplier = dragStart.dy >= dragBounds.top + (dragBounds.height / 2) ? -1 : 1;
      return (pi / 8) * (cardOffset.dx / dragBounds.width) * rotationCornerMultiplier;
    } else {
      return 0.0;
    }
  }

  Offset _rotationOrigin(Rect dragBounds) {
    if(dragStart != null) {
      return dragStart - dragBounds.topLeft;
    } else {
      return Offset(0.0, 0.0);
    }
  }

  Offset _chooseRandomDragStart() {
    final cardContext = profileCardKey.currentContext;
    final cardTopLeft =
        (cardContext.findRenderObject() as RenderBox).localToGlobal(const Offset(0.0, 0.0));
    final dragStartY =
        cardContext.size.height * (new Random().nextDouble() < 0.5 ? 0.25 : 0.75) + cardTopLeft.dy;
    return new Offset(cardContext.size.width / 2 + cardTopLeft.dx, dragStartY);
  }

  void _slideLeft() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double screenWidth = context.size.width;
      dragStart = _chooseRandomDragStart();
      slideOutTween = Tween(begin: Offset(0.0, 0.0), end: Offset(-2  * screenWidth, 0.0));

      slideOutAnimation.forward(from: 0.0);
    });
  }

  void _slideRight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double screenWidth = context.size.width;
      dragStart = _chooseRandomDragStart();
      slideOutTween = Tween(begin: Offset(0.0, 0.0), end: Offset(2  * screenWidth, 0.0));

      slideOutAnimation.forward(from: 0.0);
    });
  }

  void _slideUp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double screenHeight = context.size.height;
      dragStart = _chooseRandomDragStart();
      slideOutTween = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, -2  * screenHeight));

      slideOutAnimation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnchoredOverlay (
      showOverlay: true,
      child: Center(),
      overlayBuilder: (BuildContext overlayContext, Rect anchorBounds, Offset anchor){
        return CenterOffset (
          position: anchor,
          child: Transform (
            transform: Matrix4.translationValues(cardOffset.dx, cardOffset.dy, 0.0)..rotateZ(_rotation(anchorBounds)),
            origin: _rotationOrigin(anchorBounds),
            child: Container (
              key: profileCardKey,
              width: anchorBounds.width,
              height: anchorBounds.height,
              padding: EdgeInsets.all(16.0),
              child: GestureDetector (
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: widget.card,
              ),
            ),
          ),
        );
      },
    );
  }

}