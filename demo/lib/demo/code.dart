import 'package:flutter/cupertino.dart';

class Code extends StatelessWidget {
  String code;

  Code(this.code);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(code),
    );
  }
}
