import 'package:flutter/material.dart';

/// Abstract class for defining a use case that is presented within the demo app.
abstract class UseCase {
  /// The name of the use case.
  String name;

  /// Description of the use case.
  String description;

  /// Path to the file containing the sample code of the use case.
  String codeFile;

  /// The `Widget` representing a preview of the given use case.
  Widget preview;
}
