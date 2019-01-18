import 'package:flutter/material.dart';

class SelectedPhotoIndicator extends StatelessWidget {

  final int photoCount;
  final int visiblePhotoIndex;

  SelectedPhotoIndicator({
    @required this.photoCount,
    @required this.visiblePhotoIndex
  });

  List<Widget> _buildIndicators() => List<Widget>.generate(photoCount, (int i) => _buildIndicator(i == visiblePhotoIndex));

  Widget _buildIndicator(bool isActive) {
    return Expanded (
      child: Padding (
        padding: EdgeInsets.only(left: 2.0, right: 2.0),
        child: Container (
          height: 3.0,
          decoration: BoxDecoration (
            borderRadius: BorderRadius.circular(2.5),
            color: isActive ? Colors.white : Colors.black.withOpacity(0.2),
            boxShadow: isActive ? [
              BoxShadow (
                color: Color(0x22000000),
                spreadRadius: 0.0,
                blurRadius: 2.0,
                offset: Offset(0.0, 1.0),
              )
            ] : []
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.all(8.0),
      child: Row (
        children: _buildIndicators(),
      ),
    );
  }

}