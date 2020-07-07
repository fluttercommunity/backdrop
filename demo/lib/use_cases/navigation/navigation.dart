import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Navigation preview app.
class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [HomePage(), ItemsPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Navigation Example"),
        ),
        stickyFrontLayer: true,
        frontLayer: _pages[_currentIndex],
        backLayer: BackdropNavigationBackLayer(
          items: [
            ListTile(
                title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
            )),
            ListTile(
                title: Text(
              "Products",
              style: TextStyle(color: Colors.white),
            )),
          ],
          onTap: (int position) => {setState(() => _currentIndex = position)},
          separator: Divider(),
        ),
        subHeader: _currentIndex == 0
            ? null // no subHeader for home-page
            : BackdropSubHeader(
                title: Text("Our products"),
              ),
      ),
    );
  }
}

/// Home page of the online shop.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
              "Welcome to the online shop!",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          child: Text(
            "Please navigate to the products page to choose your product.",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

/// Items page showing the online shop's products.
class ItemsPage extends StatelessWidget {
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
