# backdrop

[![pub.dev](https://img.shields.io/pub/v/backdrop?logo=flutter)](https://pub.dev/packages/backdrop)
[![Gitlab Issues](https://img.shields.io/badge/dynamic/json?label=issues&query=%24.open_issues_count&url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&logo=gitlab)](https://gitlab.com/daadu/backdrop/issues)
[![Gitlab Contributors](https://img.shields.io/github/contributors/daadu/backdrop?logo=gitlab)](https://gitlab.com/daadu/backdrop/blob/master/AUTHORS)
[![Gitlab Stars](https://img.shields.io/badge/dynamic/json?label=stars&query=%24.star_count&url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&logo=gitlab)](https://gitlab.com/daadu/backdrop/-/starrers)
[![Gitlab Forks](https://img.shields.io/badge/dynamic/json?label=forks&query=%24.forks_count&url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&logo=gitlab)](https://gitlab.com/daadu/backdrop/-/forks)

[Backdrop](https://material.io/design/components/backdrop.html) implementation in flutter. 

This widget is in active development. Wait for the stable v1.0.0. ___Any contribution, idea, criticism or feedback is welcomed.___

## Quick links

| | |
|-|-|
| __package__ | https://pub.dev/packages/backdrop |
| __Git Repo__ | https://gitlab.com/daadu/backdrop |
| __Issue Tracker__ | https://gitlab.com/daadu/backdrop/issues |
| Github Mirror Repo  | https://github.com/daadu/backdrop |

## Getting started
Follow the medium article to [__Quickly Implement Backdrop in Flutter.__](https://medium.com/@daadu/backdrop-with-flutter-acfa9fee7d2f)

## Usage
### BackdropScaffold
Use `BackdropScaffold` instead of the standard `Scaffold` in your app.
A `backLayer` and a `frontLayer` have to be defined for the backdrop to work.

```dart
BackdropScaffold(
    title: Text("Backdrop Example"),
    backLayer: Center(
        child: Text("Back Layer"),
    ),
    frontLayer: Center(
        child: Text("Front Layer"),
    ),
    iconPosition: BackdropIconPosition.leading,
)
```
<div align="center">
<img src="https://gitlab.com/daadu/backdrop/raw/master/.gitlab/backdrop.gif"  height="500" alt="BackdropScaffold example">
</div>

### Navigation with backdrop
To use backdrop for navigation, use the provided `BackdropNavigationBackLayer` as `backLayer`.

The `BackdropNavigationBackLayer` contains a property `items` representing the list elements shown on the back layer. The front layer has to be "manually" set depending on the current index, which can be accessed with the `onTap` callback.

```dart
class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _frontLayers = [Widget1(), Widget2()];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        title: Text("Backdrop Navigation Example"),
        iconPosition: BackdropIconPosition.leading,
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          ),
        ],
        frontLayer: _frontLayers[_currentIndex],
        backLayer: BackdropNavigationBackLayer(
          items: [
            ListTile(title: Text("Widget 1")),
            ListTile(title: Text("Widget 2")),
          ],
          onTap: (int position) => {setState(() => _currentIndex = position)},
        ),
      ),
    );
  }
}
```

<div align="center">
<img src="https://gitlab.com/daadu/backdrop/raw/master/.gitlab/backdrop_navigation.gif"  height="500" alt="BackdropNavigationScaffold example">
</div>

For more information, check out sample code in the [example directory](https://gitlab.com/daadu/backdrop/tree/master/example)

## Contribute
1. You'll need a gitlab account. (Sorry, if you had to create one!!)
2. Fork the [repository](https://gitlab.com/daadu/backdrop).
3. Implement features from to-do, fix issues, etc.
4. Add your name and email in AUTHORS file
5. Send merge request.
6. Star this project.
7. Become a hero!!

## Features and bugs
Please file feature requests and bugs at the [issue tracker](https://gitlab.com/daadu/backdrop/issues).

## TODO
- Properly document the usage of the widget in README.md
- ~~Properly document classes and public methods~~
- ~~scaffoldKey provided to access scaffold directly~~
- ~~Write an example flutter app to demonstrate options and functionality~~
- ~~Using InheritedWIdget for storing controller in state and accessing it throughout~~
- ~~Dynamic height for backdrop - based on height of backpanel~~
- ~~Fixed height for backdrop - provided in argument of BackdropScaffold~~
- ~~BackdropNavigation : Using backpanel for navigation~~
- BackdropActionBar : `AppBar` equivalent for backdrop. Behaviour of it should be configurable based on which layer is visible.
- subheader argument (optional) in BackdropScaffold
- ~~BackdropToggle : widget to fling backdrop anywhere inside the scaffol~~
- ~~BackdropButton : widget that build button with BackdropToggle with default menu_close icon. Can directly be used in actions~~.
