import 'package:demo/data/test_use_case_1.dart';
import 'package:demo/data/use_case.dart';
import 'package:demo/demo/demo_page.dart';
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
  List<UseCase> _useCases = [UseCase1()];

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
            child:
                Text("This app shows some use cases for the backdrop widget."),
          ),
          ListView.builder(
            itemCount: _useCases.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(_useCases[index].name),
              onTap: () => _openDemoPage(context, _useCases[index]),
            ),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  _openDemoPage(BuildContext context, UseCase useCase) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DemoPage(useCase)));
  }
}
