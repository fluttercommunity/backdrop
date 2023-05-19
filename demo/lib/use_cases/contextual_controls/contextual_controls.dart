import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Contextual controls preview app.
class ContextualControls extends StatefulWidget {
  /// Default constructor for [ContextualControls].
  const ContextualControls({Key? key}) : super(key: key);

  @override
  _ContextualControlsState createState() => _ContextualControlsState();
}

class _ContextualControlsState extends State<ContextualControls> {
  static final _colorMap = {
    Colors.black: "Black",
    Colors.red: "Red",
    Colors.green: "Green",
    Colors.blue: "Blue"
  };
  static const _ramChoices = [4, 8, 16];

  Color _color = _colorMap.keys.first;
  double _resolution = 15.0;
  int _ram = _ramChoices.first;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("Contextual Controls Example"),
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
              children: const [
                Text(
                  "Color",
                ),
              ],
            ),
            title: DropdownButton<Color>(
              isExpanded: true,
              value: _color,
              items: _colorMap.keys.map<DropdownMenuItem<Color>>((Color c) {
                return DropdownMenuItem<Color>(
                  value: c,
                  child: Text(_colorMap[c]!),
                );
              }).toList(),
              onChanged: (Color? newValue) {
                setState(() {
                  _color = newValue!;
                });
              },
            ),
          ),
          ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Resolution"),
                ],
              ),
              title: Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.lightBlue,
                  value: _resolution,
                  min: 14,
                  max: 17,
                  label: "$_resolution\"",
                  divisions: 3,
                  onChanged: (value) {
                    setState(() {
                      _resolution = value;
                    });
                  })),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("RAM"),
              ],
            ),
            title: DropdownButton<int>(
              isExpanded: true,
              value: _ram,
              items: _ramChoices.map<DropdownMenuItem<int>>((int r) {
                return DropdownMenuItem<int>(
                  value: r,
                  child: Text("${r.toString()} GB"),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _ram = newValue!;
                });
              },
            ),
          ),
          Builder(
              builder: (context) => MaterialButton(
                    child: const Text("Return to product page"),
                    onPressed: () => Backdrop.of(context).fling(),
                  ))
        ],
        shrinkWrap: true,
      );

  Widget _createFrontLayer(BuildContext context) => Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.computer,
                  size: 64.0,
                  color: _color,
                ),
                Text(
                  "Laptop",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .apply(color: Colors.black),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star_half, color: Colors.grey),
                    ],
                  ),
                  const Text(
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
                const Text(
                  "Price",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: const Text(
                    "\$999",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 32.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("Resolution")],
                  ),
                  Text(
                    "${_resolution.toString()}\"",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text("RAM")],
                  ),
                  Text(
                    "${_ram.toString()} GB",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(
                    builder: (context) => ElevatedButton(
                      child: const Text("Configure"),
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
