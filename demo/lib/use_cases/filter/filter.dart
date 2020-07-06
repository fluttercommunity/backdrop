import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Filter preview app.
class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Filter Example"),
        ),
        backLayer: Center(
          child: Text("Back Layer"),
        ),
        subHeader: BackdropSubHeader(
          title: Text("Sub Header"),
        ),
        frontLayer: Center(
          child: Text("Filter"),
        ),
      ),
    );
  }
}
