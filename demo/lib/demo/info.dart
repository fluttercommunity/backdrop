import 'package:flutter/material.dart';

/// Class for presenting information about a use case to the user.
class Info extends StatelessWidget {
  /// The title of the use case.
  final String title;

  /// The description of the use case.
  final String description;

  /// Creates an instance of [Info].
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
          margin: EdgeInsets.all(16.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
