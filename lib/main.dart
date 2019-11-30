import 'package:flutter/material.dart';
import 'package:quizer/home.dart';
import 'package:quizer/splash.dart';

void  main() => runApp(MyApp());

class  MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quizer",
      theme:  ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: splashscreen(),
    );
  }
}