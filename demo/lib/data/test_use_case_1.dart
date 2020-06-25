import 'package:demo/data/use_case.dart';
import 'package:flutter/material.dart';

class UseCase1 extends UseCase {
  UseCase1() {
    name = "Test Use Case 1";
    description = "This is the description of test use case 1";
    code = "void helloWorld() {\n}";
    preview = Container(
      child: Center(child: Text("Preview!!!")),
      color: Colors.orange,
    );
  }
}
