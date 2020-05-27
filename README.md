[![Flutter Community: backdrop](https://fluttercommunity.dev/_github/header/backdrop)](https://github.com/fluttercommunity/community)

# backdrop

[![pub.dev](https://img.shields.io/pub/v/backdrop?logo=flutter)](https://pub.dev/packages/backdrop)
[![Gitter](https://badges.gitter.im/flutter-backdrop/community.svg)](https://gitter.im/flutter-backdrop/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![All Contributors](https://img.shields.io/badge/all_contributors-7-orange.svg)](#contributors-)
[![GitHub issues](https://img.shields.io/github/issues/fluttercommunity/backdrop?logo=github)](https://github.com/fluttercommunity/backdrop/issues)
[![GitHub milestone](https://img.shields.io/github/milestones/progress-percent/fluttercommunity/backdrop/1?logo=github)](https://github.com/fluttercommunity/backdrop/milestone/1)
[![GitHub stars](https://img.shields.io/github/stars/fluttercommunity/backdrop?logo=github)](https://github.com/fluttercommunity/backdrop/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/fluttercommunity/backdrop?logo=github)](https://github.com/fluttercommunity/backdrop/network)
[![Gitlab stars](https://img.shields.io/badge/dynamic/json?label=stars&query=%24.star_count&url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&logo=gitlab)](https://gitlab.com/daadu/backdrop/-/starrers)
[![Gitlab forks](https://img.shields.io/badge/dynamic/json?label=forks&query=%24.forks_count&url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&logo=gitlab)](https://gitlab.com/daadu/backdrop/-/forks)

[Backdrop](https://material.io/design/components/backdrop.html) implementation in flutter. 

This widget is in active development. Wait for the stable [v1.0](https://github.com/fluttercommunity/backdrop/milestone/1). 
___Any contribution, idea, criticism or feedback is welcomed.___

## Quick links

| | |
|-|-|
| __package__ | https://pub.dev/packages/backdrop |
| __Git Repo__  | https://github.com/fluttercommunity/backdrop |
| __Issue Tracker__ | https://github.com/fluttercommunity/backdrop/issues |
| __Chat Room__ | https://gitter.im/flutter-backdrop |

## Getting started
Follow the medium article to [__Quickly Implement Backdrop in Flutter.__](https://medium.com/@daadu/backdrop-with-flutter-acfa9fee7d2f)

## Usage
### BackdropScaffold
Use `BackdropScaffold` instead of the standard `Scaffold` in your app.
A `backLayer` and a `frontLayer` have to be defined for the backdrop to work.

```dart
BackdropScaffold(
  appBar: BackdropAppBar(
    title: Text("Backdrop Example"),
    actions: <Widget>[
      BackdropToggleButton(
        icon: AnimatedIcons.list_view,
      )
    ],
  ),
  backLayer: Center(
    child: Text("Back Layer"),
  ),
  frontLayer: Center(
    child: Text("Front Layer"),
  ),
)
```
<div align="center">
<img src="https://github.com/fluttercommunity/backdrop/raw/master/.github/backdrop.gif"  height="500" alt="BackdropScaffold example">
</div>

### Navigation with backdrop
To use backdrop for navigation, use the provided `BackdropNavigationBackLayer` as `backLayer`.

The `BackdropNavigationBackLayer` contains a property `items` representing the list elements shown on the back layer. The front layer has to be "manually" set depending on the current index, which can be accessed with the `onTap` callback.

```dart
int _currentIndex = 0;
final List<Widget> _pages = [Widget1(), Widget2()];

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Backdrop Demo',
    home: BackdropScaffold(
      appBar: BackdropAppBar(
        title: Text("Navigation Example"),
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          )
        ],
      ),
      stickyFrontLayer: true,
      frontLayer: _pages[_currentIndex],
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
```

<div align="center">
<img src="https://github.com/fluttercommunity/backdrop/raw/master/.github/backdrop_navigation.gif"  height="500" alt="BackdropNavigationScaffold example">
</div>

For more information, check out sample code in the [example directory](https://github.com/fluttercommunity/backdrop/tree/master/example)

## Contribute
1. You'll need a GitHub account.
2. Fork the [repository](https://github.com/fluttercommunity/backdrop).
3. Pick an issue to work on from [issue tracker](https://github.com/fluttercommunity/backdrop/issues).
4. Implement it.
5. Add your name and email in `authors` section in `pubspec.yaml` file.
6. Send merge request.
7. Star this project.
8. Become a hero!!

## Features and bugs
Please file feature requests and bugs at the [issue tracker](https://github.com/fluttercommunity/backdrop/issues).

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://bhikadia.com"><img src="https://avatars1.githubusercontent.com/u/4963236?v=4" width="100px;" alt=""/><br /><sub><b>Harsh Bhikadia</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=daadu" title="Code">💻</a> <a href="#ideas-daadu" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/WieFel"><img src="https://avatars0.githubusercontent.com/u/8345062?v=4" width="100px;" alt=""/><br /><sub><b>Felix Wielander</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=WieFel" title="Code">💻</a> <a href="https://github.com/fluttercommunity/backdrop/commits?author=WieFel" title="Documentation">📖</a><a href="https://github.com/fluttercommunity/backdrop/issues/created_by/WieFel" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://bringmos.com/"><img src="https://avatars0.githubusercontent.com/u/64806665?v=4" width="100px;" alt=""/><br /><sub><b>Bringmos</b></sub></a><br /><a href="https://gitlab.com/daadu/backdrop/-/issues?scope=all&utf8=%E2%9C%93&state=all&author_username=bringmos" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/gspencergoog"><img src="https://avatars0.githubusercontent.com/u/8867023?v=4" width="100px;" alt=""/><br /><sub><b>Greg Spencer</b></sub></a><br /><a href="https://gitlab.com/daadu/backdrop/-/issues?scope=all&utf8=%E2%9C%93&state=all&author_username=gspencergoog" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/cicelcup"><img src="https://avatars0.githubusercontent.com/u/48078472?v=4" width="100px;" alt=""/><br /><sub><b>Jorge A Peroza M</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=cicelcup" title="Code">💻</a><a href="https://github.com/fluttercommunity/backdrop/issues/created_by/cicelcup" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/heath3n"><img src="https://avatars0.githubusercontent.com/u/8888204?v=4" width="100px;" alt=""/><br /><sub><b>Matt Newell</b></sub></a><br /><a href="https://gitlab.com/daadu/backdrop/-/issues?scope=all&utf8=%E2%9C%93&state=all&author_username=heath3n" title="Bug reports">🐛</a></td>
    <td align="center"><a href="http://danielborges93.com/"><img src="https://avatars0.githubusercontent.com/u/1283243?v=4" width="100px;" alt=""/><br /><sub><b>Daniel Borges</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=danielborges93" title="Code">💻</a><a href="https://github.com/fluttercommunity/backdrop/issues/created_by/danielborges93" title="Bug reports">🐛</a></td>    
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
