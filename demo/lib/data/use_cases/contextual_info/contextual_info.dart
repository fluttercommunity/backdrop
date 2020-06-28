import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Contextual info preview app.
class ContextualInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contextual Info',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Contextual Info Example"),
        ),
        backLayer: Center(
          child: Text("Back Layer"),
        ),
        subHeader: BackdropSubHeader(
          title: Text("Sub Header"),
        ),
        frontLayer: Center(
          child: Text("Contextual Info"),
        ),
      ),
    );
  }
}
