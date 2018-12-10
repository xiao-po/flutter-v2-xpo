import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:v2_xpo/view/IndexPage.dart';

void main() {
  debugInstrumentationEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new IndexPage(title: 'tes1t'),
    );
  }
}







