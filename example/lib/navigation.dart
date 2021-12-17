import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const Widget1(), const Widget2()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("Navigation Example"),
          actions: const <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        stickyFrontLayer: true,
        frontLayer: _pages[_currentIndex],
        backLayer: BackdropNavigationBackLayer(
          items: const [
            ListTile(title: Text("Widget 1")),
            ListTile(title: Text("Widget 2")),
          ],
          onTap: (int position) => {setState(() => _currentIndex = position)},
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  const Widget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Widget 1"));
  }
}

class Widget2 extends StatelessWidget {
  const Widget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Widget 2"));
  }
}
