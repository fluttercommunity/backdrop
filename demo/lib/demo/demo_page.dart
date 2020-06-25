import 'package:demo/demo/code.dart';
import 'package:demo/demo/info.dart';
import 'package:demo/demo/preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  String name;

  DemoPage(this.name);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Widget _current;

  @override
  void initState() {
    _current = Info();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo " + widget.name),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            color: _current is Info ? null : Colors.white,
            onPressed: () {
              setState(() {
                _current = Info();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.visibility),
            color: _current is Preview ? null : Colors.white,
            onPressed: () {
              setState(() {
                _current = Preview();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.code),
            color: _current is Code ? null : Colors.white,
            onPressed: () {
              setState(() {
                _current = Code();
              });
            },
          ),
        ],
      ),
      body: _current,
    );
  }
}
