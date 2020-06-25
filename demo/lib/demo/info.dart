import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  String title;
  String description;

  Info(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Text(description),
      ],
    );
  }
}
