import 'package:flutter/cupertino.dart';

class Preview extends StatelessWidget {
  Widget preview;

  Preview(this.preview);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          child: preview),
    );
  }
}
