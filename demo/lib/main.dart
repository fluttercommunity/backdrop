import 'package:demo/theme_data.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Backdrop Gallery",
      theme: GalleryThemeData.darkThemeData,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backdrop Gallery"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
                "This app shows some use cases for the backdrop widget."),
          ),
          ListView(
            shrinkWrap: true,
            children: [
            ListTile(title: Text("Use case 1"), onTap: () {},),
            ListTile(title: Text("Use case 2"), onTap: () {},)
          ],),
        ],
      ),
    );
  }
}
