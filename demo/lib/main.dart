import 'package:demo/data/use_case.dart';
import 'package:demo/use_cases/contextual_controls/contextual_controls_use_case.dart';
import 'package:demo/use_cases/contextual_info/contextual_info_use_case.dart';
import 'package:demo/use_cases/filter/filter_use_case.dart';
import 'package:demo/use_cases/navigation/navigation_use_case.dart';
import 'package:flutter/material.dart';
import 'package:gallerize/gallerize.dart';
import 'package:gallerize/themes/gallerize_theme_data.dart';

void main() => runApp(DemoApp());

/// Demo app that provides a show-case of different backdrop use cases.
class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Backdrop Gallery",
      theme: GallerizeThemeData.darkThemeData,
      home: HomePage(),
    );
  }
}

/// The home page of the demo app showing a selection of use cases.
class HomePage extends StatelessWidget {
  List<UseCase> _useCases = [
    ContextualInfoUseCase(),
    ContextualControlsUseCase(),
    NavigationUseCase(),
    FilterUseCase(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backdrop Gallery"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child:
                Text("This app shows some use cases for the backdrop widget. "
                    "Open any one to show information about it, preview it and "
                    "look at its code."),
          ),
          ListView.separated(
            itemCount: _useCases.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(_useCases[index].name),
              onTap: () => _openDemoPage(context, _useCases[index]),
            ),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(),
          ),
        ],
      ),
    );
  }

  _openDemoPage(BuildContext context, UseCase useCase) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GallerizePage(
                  name: useCase.name,
                  description: useCase.description,
                  preview: useCase.preview,
                  codeFile: useCase.codeFile,
                )));
  }
}
