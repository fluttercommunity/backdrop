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
        iconPosition: BackdropIconPosition.leading,
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          ),
        ],
        backdropNavigationBackLayer: BackdropNavigationBackLayer(
          backdropNavigationItems: [
            BackdropNavigationItem(
                item: ListTile(title: Text("Widget1")), frontLayer: Widget1()),
            BackdropNavigationItem(
                item: ListTile(title: Text("Widget2")), frontLayer: Widget2()),
          ],
          onTap: (int position) =>
              print("Navigation entry " + position.toString() + " tapped"),
        ),
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Widget 1")),
    );
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Widget 2"));
  }
}
