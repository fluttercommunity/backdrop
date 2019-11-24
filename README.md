# backdrop
[Backdrop](https://material.io/design/components/backdrop.html) implementation in flutter. 

This widget is in active development. Wait for the stable v1.0.0. ___Any contribution, idea, criticism or feedback is welcomed.___

## Getting started
Follow the medium article to [__Quickly Implement Backdrop in Flutter.__](https://medium.com/@daadu/backdrop-with-flutter-acfa9fee7d2f) 

## Usage
### BackdropScaffold
Use `BackdropScaffold` instead of the standard `Scaffold` in your app.<br/>
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
<img src="https://gitlab.com/daadu/backdrop/raw/master/.gitlab/backdrop.gif"  width="500" alt="BackdropScaffold example">
</div>

### Navigation with backdrop
To use backdrop for navigation, use the provided `BackdropNavigationScaffold` widget.<br/>
Instead of defining a front and back layer, a list of `NavigationTuple` has to be passed for the parameter `navigationComponents`. `NavigationTuple` contains the menu item displayed on the back layer and its corresponding main content of the front layer.

```dart
BackdropNavigationScaffold(
    title: Text("Backdrop Example"),
    iconPosition: BackdropIconPosition.leading,
    navigationComponents: [
        NavigationTuple(
            menuItem: ListTile(title: Text("Widget 1")),
            content: Center(child: Text("Widget 1"),
        ),
        NavigationTuple(
            menuItem: ListTile(title: Text("Widget 2")),
            content: Center(child: Text("Widget 2"),
        )
    ],
    onNavigationChange: (current) {
        print("Navigation item changed");
    },
)
```

<div align="center">
<img src="https://gitlab.com/daadu/backdrop/raw/master/.gitlab/backdrop_navigation.gif"  width="500" alt="BackdropNavigationScaffold example">
</div><br/>

For more information, check out sample code in the [example directory](https://gitlab.com/daadu/backdrop/tree/master/example)

## Contribute
1. You'll need a gitlab account. (Sorry, if you had to create one!!)
2. Fork the [repository](https://gitlab.com/daadu/backdrop).
3. Implement features from to-do, fix issues, etc.
4. Send merge request.
5. Star this project.
6. Become a hero!!

## Features and bugs
Please file feature requests and bugs at the [issue tracker](https://gitlab.com/daadu/backdrop/issues).

## TODO
- Properly document the usage of the widget in README.md
- Properly document classes and public methods
- ~~scaffoldKey provided to access scaffold directly~~
- ~~Write an example flutter app to demonstrate options and functionality~~
- ~~Using InheritedWIdget for storing controller in state and accessing it throughout~~
- ~~Dynamic height for backdrop - based on height of backpanel~~
- ~~Fixed height for backdrop - provided in argument of BackdropScaffold~~
- ~~BackdropNavigation : Using backpanel for navigation~~
- BackdropTitle : Different title for backpanel and frontpanel visibility
- BackdropAction : Action with view in backpanel
- subheader argument (optional) in BackdropScaffol
- ~~BackdropToggle : widget to fling backdrop anywhere inside the scaffol~~
- ~~BackdropButton : widget that build button with BackdropToggle with default menu_close icon. Can directly be used in actions~~.
