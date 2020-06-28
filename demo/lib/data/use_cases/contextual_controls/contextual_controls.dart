import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Contextual controls preview app.
class ContextualControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contextual Controls',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Contextual Controls Example"),
        ),
        backLayer: Center(
          child: Text("Back Layer"),
        ),
        subHeader: BackdropSubHeader(
          title: Text("Sub Header"),
        ),
        frontLayer: Center(
          child: Text("Contextual Controls"),
        ),
      ),
    );
  }
}
