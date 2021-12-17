/*
*
* Check live demo with various use-cases and its code on https://fluttercommunity.github.io/backdrop/demo/#/
*
* */

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Example app for demoing [BackdropScaffold]
class MyApp extends StatelessWidget {
  /// Default constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("Backdrop Example"),
          actions: const <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: const Center(
          child: Text("Back Layer"),
        ),
        subHeader: const BackdropSubHeader(
          title: Text("Sub Header"),
        ),
        frontLayer: const Center(
          child: Text("Front Layer"),
        ),
      ),
    );
  }
}
