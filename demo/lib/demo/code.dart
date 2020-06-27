import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';

class Code extends StatefulWidget {
  String codeFile;

  Code(this.codeFile);

  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  String code;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString(widget.codeFile),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: HighlightView(
                snapshot.data,
                language: "dart",
                theme: draculaTheme,
                padding: EdgeInsets.all(8.0),
                textStyle: TextStyle(
                  fontSize: 11,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
