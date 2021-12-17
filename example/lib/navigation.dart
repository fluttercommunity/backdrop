import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Example app for demoing [BackdropNavigationBackLayer]
class MyApp extends StatefulWidget {
  /// Default constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const _Widget1(), const _Widget2()];

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

class _Widget1 extends StatelessWidget {
  const _Widget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Widget 1"));
  }
}

class _Widget2 extends StatelessWidget {
  const _Widget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Widget 2"));
  }
}
