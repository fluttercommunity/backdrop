import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropNavigationScaffold(
        title: Text("Backdrop Example"),
        iconPosition: BackdropIconPosition.leading,
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          ),
        ],
        navigationComponents: [
          NavigationTuple(
              menuItem: ListTile(title: Text("Widget 1")), content: Widget1()),
          NavigationTuple(
              menuItem: ListTile(title: Text("Widget 2")), content: Widget2())
        ],
        onNavigationChange: (current) {
          print("Navigation item changed");
        },
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
