import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            return SingleChildScrollView(child: Text(snapshot.data));
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
