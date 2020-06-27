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
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
