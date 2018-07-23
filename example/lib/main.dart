import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        title: Text("Backdrop Example"),
        backpanel: Center(
          child: Text("Backpanel"),
        ),
        body: Center(
          child: Text("Body"),
        ),
      ),
    );
  }
}
