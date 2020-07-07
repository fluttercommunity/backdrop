import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

/// Contextual info preview app.
class ContextualInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Contextual Info Example"),
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
                  "Name",
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
                Text("Year of production"),
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
                Text("Place of Manufacture"),
              ],
            ),
            title: Text(
              "USA",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Price"),
              ],
            ),
            title: Text(
              "\$999",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
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
            Container(
              margin: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(
                    builder: (context) => RaisedButton(
                      child: Text("More about this product"),
                      onPressed: () => Backdrop.of(context).fling(),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text("Reviews",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .apply(color: Colors.black)),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Really satisfied!"),
              subtitle: Text("John Doe"),
              trailing: Text("5/5"),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Good price!"),
              subtitle: Text("Jane Doe"),
              trailing: Text("4.5/5"),
            )
          ],
        ),
      );
}
