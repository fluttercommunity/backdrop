import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

/// Navigation preview app.
class Navigation extends StatefulWidget {
  /// Default constructor for [Navigation].
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const _HomePage(), const _ItemsPage()];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("Navigation Example"),
        ),
        stickyFrontLayer: true,
        frontLayer: _pages[_currentIndex],
        backLayer: _createBackLayer(),
        subHeader: _currentIndex == 0
            ? null // no subHeader for home-page
            : const BackdropSubHeader(
                title: Text("Our products"),
              ),
      ),
    );
  }

  Widget _createBackLayer() => BackdropNavigationBackLayer(
        items: const [
          ListTile(
              title: Text(
            "Home",
          )),
          ListTile(
              title: Text(
            "Products",
          )),
        ],
        onTap: (int position) => {setState(() => _currentIndex = position)},
        separatorBuilder: (context, position) => const Divider(),
      );
}

/// Home page of the online shop.
class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Text(
              "Welcome to the online shop!",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          child: const Text(
            "Please navigate to the products page to choose your product.",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

/// Items page showing the online shop's products.
class _ItemsPage extends StatelessWidget {
  const _ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
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
    );
  }
}
