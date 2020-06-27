import 'package:demo/data/use_case.dart';
import 'package:demo/demo/code.dart';
import 'package:demo/demo/info.dart';
import 'package:demo/demo/preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class for presenting a entire use case to the user. The user can switch bet-
/// ween info, preview and source code pages concerning the given use case.
class DemoPage extends StatefulWidget {
  /// The use case to be presented to the user.
  UseCase useCase;

  /// Creates an instance of [DemoPage].
  DemoPage(this.useCase);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Widget _current;

  @override
  void initState() {
    _current = Info(widget.useCase.name, widget.useCase.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.useCase.name),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            color: _current is Info ? null : Colors.white,
            onPressed: () {
              setState(() {
                _current =
                    Info(widget.useCase.name, widget.useCase.description);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.visibility),
            color: _current is Preview ? null : Colors.white,
            onPressed: () {
              setState(() {
                _current = Preview(widget.useCase.preview);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.code),
            color: _current is Code ? null : Colors.white,
            onPressed: () {
              setState(() {
                _current = Code(widget.useCase.codeFile);
              });
            },
          ),
        ],
      ),
      body: _current,
    );
  }
}
