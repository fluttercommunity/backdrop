import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Contextual controls preview app.
class ContextualControls extends StatefulWidget {
  @override
  _ContextualControlsState createState() => _ContextualControlsState();
}

class _ContextualControlsState extends State<ContextualControls> {
  static const _COLOR_CHOICES = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue
  ];
  static const _RESOLUTION_CHOICES = [13, 14, 15, 17];
  static const _RAM_CHOICES = [4, 8, 16];

  Color _color = _COLOR_CHOICES.first;
  int _resolution = _RESOLUTION_CHOICES.first;
  int _ram = _RAM_CHOICES.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contextual Controls',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Contextual Controls Example"),
          automaticallyImplyLeading: false,
        ),
        backLayer: _createBackLayer(context),
        frontLayer: _createFrontLayer(context),
        stickyFrontLayer: true,
      ),
    );
  }

  Widget _createBackLayer(BuildContext context) => ListView(
        children: [
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Color",
                ),
              ],
            ),
            title: Text(
              "Laptop Model X",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Resolution"),
              ],
            ),
            title: Text(
              "2019",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("RAM"),
              ],
            ),
            title: Text(
              "USA",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Builder(
              builder: (context) => MaterialButton(
                    child: Text("Return to product page"),
                    onPressed: () => Backdrop.of(context).fling(),
                  ))
        ],
        shrinkWrap: true,
      );

  Widget _createFrontLayer(BuildContext context) => Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.computer,
                  size: 64.0,
                ),
                Text(
                  "Laptop",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .apply(color: Colors.black),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star_half, color: Colors.grey),
                    ],
                  ),
                  Text(
                    "73 Reviews",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "\$999",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 32.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Resolution")],
                  ),
                  Text(
                    "${_resolution.toString()}\"",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("RAM")],
                  ),
                  Text(
                    "${_ram.toString()} GB",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(
                    builder: (context) => RaisedButton(
                      child: Text("Configure"),
                      onPressed: () => Backdrop.of(context).fling(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
