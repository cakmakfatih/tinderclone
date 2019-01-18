import 'dart:math' show max;
import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.pink,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.2,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    return Icon(Icons.fiber_manual_record, size: 15.0, color: Colors.pink.withOpacity(selectedness));
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

// https://gist.github.com/collinjackson/4fddbfa2830ea3ac033e34622f278824
// bu sayfadan aldım, düzenledim