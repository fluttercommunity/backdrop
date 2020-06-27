import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomePage(), ArticlesPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Navigation Example"),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        stickyFrontLayer: true,
        frontLayer: _pages[_currentIndex],
        backLayer: BackdropNavigationBackLayer(
          items: [
            ListTile(title: Text("Home")),
            ListTile(title: Text("Articles")),
          ],
          onTap: (int position) => {setState(() => _currentIndex = position)},
          separator: Divider(),
        ),
        subHeader: _currentIndex == 0
            ? null // no subHeader for home-page
            : BackdropSubHeader(
                title: Text("Our articles"),
              ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Welcome to the online shop!",
      style: Theme.of(context).textTheme.headline6,
    ));
  }
}

class ArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.computer),
          title: Text("Laptop"),
        ),
        ListTile(
          leading: Icon(Icons.child_friendly),
          title: Text("Stroller"),
        ),
        ListTile(
          leading: Icon(Icons.tv),
          title: Text("TV"),
        ),
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text("Car"),
        ),
      ],
      shrinkWrap: true,
    );
  }
}
