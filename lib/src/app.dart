import 'package:flutter/material.dart';
import 'scenes/out/entrance.dart';
import 'scenes/in/main_controller.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black
    ));
    return MaterialApp (
      theme: ThemeData (
        primaryColor: Colors.red
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Entrance(),
        '/main-controller': (BuildContext context) => MainController()
      }
    );
  }

}