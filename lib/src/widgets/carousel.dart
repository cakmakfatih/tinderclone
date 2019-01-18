import 'package:flutter/material.dart';
import 'dots_indicator.dart';

class CarouselModel {
  final String title;
  final Widget child;

  CarouselModel({@required this.title, @required this.child});
}

class Carousel extends StatefulWidget {

  final List<CarouselModel> items;
  Carousel(this.items);

  @override
  CarouselState createState() => CarouselState();

}

class CarouselState extends State<Carousel> {

  int active = 0;
  PageController _pageController;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(handleTabChange);
  }


  void handleTabChange(){
    active = _pageController.page.toInt();
  }
  
  Widget _singleCard(CarouselModel item) {
    return  Column (
      children: <Widget> [
        Container (
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width * 4 / 5,
          child: Text (
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle (
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              color: Colors.teal[700]
            )
          ),
        ),
        Expanded (
          child: item.child,
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context){
    return Column (
                  children: <Widget>[
                    Expanded (
                      child: PageView (
              controller: _pageController,
              children: widget.items.map((i){
                return _singleCard(i);
              }).toList(),
                    )),
                    Container (
                        height: 55.0,
                        padding: const EdgeInsets.all(15.0),
                        child: new Center(
                          child: new DotsIndicator(
                            controller: _pageController,
                            itemCount: widget.items.length,
                            onPageSelected: (int page) {
                              _pageController.animateToPage(
                                page,
                                duration: _kDuration,
                                curve: _kCurve,
                              );
                            },
                          ),
                        ),
                    )
                  ],
                );
  }

}