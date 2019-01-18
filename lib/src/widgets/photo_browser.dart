import 'package:flutter/material.dart';
import 'selected_photo_indicator.dart';

class PhotoBrowser extends StatefulWidget {

  final List<String> photoUrls;
  final int visiblePhotoIndex;

  PhotoBrowser({
    @required this.photoUrls,
    @required this.visiblePhotoIndex,
  });

  @override
  _PhotoBrowserState createState() => _PhotoBrowserState();

}

class _PhotoBrowserState extends State<PhotoBrowser> {

  int visiblePhotoIndex;

  @override
  void initState() {
    super.initState();

    visiblePhotoIndex = widget.visiblePhotoIndex;
  }

  @override
  void didUpdateWidget(PhotoBrowser oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.visiblePhotoIndex != oldWidget.visiblePhotoIndex) {
      setState(() { 
        visiblePhotoIndex = widget.visiblePhotoIndex;
      });
    }
  }

  void _prevImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex > 0 ? visiblePhotoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      visiblePhotoIndex = visiblePhotoIndex < widget.photoUrls.length - 1 ? visiblePhotoIndex + 1 : visiblePhotoIndex;
    });
  }

  Widget _buildPhotoControls() {
    return Stack (
      fit: StackFit.expand,
      children: <Widget> [
        GestureDetector (
          onTap: _prevImage,
          child: FractionallySizedBox (
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topLeft,
            child: Container (
              color: Colors.transparent,
            ),
          ),
        ),
        GestureDetector (
          onTap: _nextImage,
          child: FractionallySizedBox (
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topRight,
            child: Container (
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack (
      fit: StackFit.expand,
      children: <Widget> [
        Image.network(
          widget.photoUrls[visiblePhotoIndex],
          fit: BoxFit.cover,
        ),
        Positioned (
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: SelectedPhotoIndicator (
            photoCount: widget.photoUrls.length,
            visiblePhotoIndex: visiblePhotoIndex,
          ),
        ),
        _buildPhotoControls()
      ],
    );
  }

}