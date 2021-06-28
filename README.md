[![Flutter Community: backdrop](https://fluttercommunity.dev/_github/header/backdrop)](https://github.com/fluttercommunity/community)

# backdrop

<p>
<a href="https://fluttercommunity.github.io/backdrop/demo/#/"><img src="https://img.shields.io/badge/check-demo-blueviolet" alt="Demo"></a>
<a href="https://gitter.im/flutter-backdrop/community?utm_source=badge&amp;utm_medium=badge&amp;utm_campaign=pr-badge"><img src="https://badges.gitter.im/flutter-backdrop/community.svg" alt="Gitter"></a>
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<a href="#contributors-"><img src="https://img.shields.io/badge/all_contributors-21-orange.svg" alt="All Contributors" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:END -->
<a href="https://pub.dev/packages/backdrop"><img src="https://img.shields.io/pub/v/backdrop?logo=dart" alt="pub.dev"></a>
<a href="https://pub.dev/packages/backdrop/score"><img src="https://badges.bar/backdrop/pub%20points" alt="pub points"></a>
<a href="https://pub.dev/packages/backdrop/score"><img src="https://badges.bar/backdrop/popularity" alt="popularity"></a>
<a href="https://pub.dev/packages/backdrop/score"><img src="https://badges.bar/backdrop/likes" alt="likes"></a>
<a href="https://github.com/fluttercommunity/backdrop/actions?query=workflow%3Aanalysis"><img src="https://github.com/fluttercommunity/backdrop/workflows/analysis/badge.svg" alt="analysis"></a>
<a href="https://github.com/fluttercommunity/backdrop/issues"><img src="https://img.shields.io/github/issues/fluttercommunity/backdrop?logo=github" alt="GitHub issues"></a>
<a href="https://github.com/fluttercommunity/backdrop/milestone/1"><img src="https://img.shields.io/github/milestones/progress-percent/fluttercommunity/backdrop/1?logo=github" alt="GitHub milestone"></a>
<a href="https://github.com/fluttercommunity/backdrop/stargazers"><img src="https://img.shields.io/github/stars/fluttercommunity/backdrop?logo=github" alt="GitHub stars"></a>
<a href="https://github.com/fluttercommunity/backdrop/network"><img src="https://img.shields.io/github/forks/fluttercommunity/backdrop?logo=github" alt="GitHub forks"></a>
<a href="https://gitlab.com/daadu/backdrop/-/starrers"><img src="https://img.shields.io/badge/dynamic/json?label=stars&amp;query=%24.star_count&amp;url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&amp;logo=gitlab" alt="Gitlab stars"></a>
<a href="https://gitlab.com/daadu/backdrop/-/forks"><img src="https://img.shields.io/badge/dynamic/json?label=forks&amp;query=%24.forks_count&amp;url=https%3A%2F%2Fgitlab.com%2Fapi%2Fv4%2Fprojects%2F7578401&amp;logo=gitlab" alt="Gitlab forks"></a>
</p>


[Backdrop](https://material.io/design/components/backdrop.html) implementation in flutter. 

This widget is in active development. 
___Any contribution, idea, criticism or feedback is welcomed.___

__NOTE: If using Flutter v1.x.x, use v0.5.x pub version.__

## Quick links

| | |
|-|-|
| __package__ | https://pub.dev/packages/backdrop |
| __Live Demo__ | https://fluttercommunity.github.io/backdrop/demo/#/ |
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

### Accessing underlying backdrop functionalities
To access backdrop related functionalities, use `Backdrop.of(context)` to get underlying `BackdropScaffoldState`.

`BackdropScaffoldState` exposes various properties and methods like:
- properties
  - `controller -> AnimationController`
  - `scaffoldKey -> GlobalKey<ScaffoldState> `
  - `isBackLayerConcealed -> bool`
  - `isBackLayerRevealed -> bool`
- methods
  - `fling()`
  - `concealBackLayer()`
  - `revealBackLayer()`

Note: `Backdrop` is an `InheritedWidget` and therefore like `Scaffold.of`, `Theme.of` and `MediaQuery.of`, the `BuildContext context` passed to `Backdrop.of(context)` should be of a `Widget` that is under the `BackdropScaffold` in the "widget tree". In other words, `Backdrop.of` called inside a widget where the `BackdropScaffold` is initalized will not work explicitly, since the `context` passed is of the widget that will build `BackdropScaffold` therefore above `BackdropScaffold`. This can be solved by either making a seperate `Widget` where `Backdrop.of` needs to be used and make it the "child" of `BackdropScaffold` or wrap the `Backdrop.of` usage around `Builder` widget so that the "correct" `context` (from `Builder`) is passed to `Backdrop.of`. This [answere on SO](https://stackoverflow.com/a/52123080/2554745) and [FWotW video on Builder](https://www.youtube.com/watch?v=xXNOkIuSYuA) gives a very good idea of how and why `Builder` works in later case.

For more information, check out sample code in the [example directory](https://github.com/fluttercommunity/backdrop/tree/master/example), [demo app](https://fluttercommunity.github.io/backdrop/demo/#/) with use-cases and code for it and [API references](https://pub.dev/documentation/backdrop/latest/backdrop/backdrop-library.html) generated by pub.dev.

## Contribute
Check proposal documents for [v1.0](https://github.com/fluttercommunity/backdrop/issues/5) and [web&desktop](https://github.com/fluttercommunity/backdrop/issues/34) milestones before you begin with any contibution.

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
    <td align="center"><a href="https://bhikadia.com"><img src="https://avatars1.githubusercontent.com/u/4963236?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Harsh Bhikadia</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=daadu" title="Code">💻</a> <a href="#ideas-daadu" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/fluttercommunity/backdrop/pulls?q=is%3Apr+reviewed-by%3Adaadu" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/WieFel"><img src="https://avatars0.githubusercontent.com/u/8345062?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Felix</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=WieFel" title="Code">💻</a> <a href="https://github.com/fluttercommunity/backdrop/commits?author=WieFel" title="Documentation">📖</a> <a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3AWieFel" title="Bug reports">🐛</a> <a href="https://github.com/fluttercommunity/backdrop/pulls?q=is%3Apr+reviewed-by%3AWieFel" title="Reviewed Pull Requests">👀</a> <a href="https://fluttercommunity.github.io/backdrop/demo/#/" title="Examples">💡</a> <a href="https://github.com/fluttercommunity/backdrop/tree/master/.github/workflows/" title="Infrastructure">🚇</a></td>
    <td align="center"><a href="https://bringmos.com/"><img src="https://avatars0.githubusercontent.com/u/64806665?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Bringmos</b></sub></a><br /><a href="https://gitlab.com/daadu/backdrop/-/issues?scope=all&utf8=%E2%9C%93&state=all&author_username=bringmos" title="Bug">🐛</a></td>
    <td align="center"><a href="https://github.com/gspencergoog"><img src="https://avatars0.githubusercontent.com/u/8867023?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Greg Spencer</b></sub></a><br /><a href="https://gitlab.com/daadu/backdrop/-/issues?scope=all&utf8=%E2%9C%93&state=all&author_username=gspencergoog" title="Bug">🐛</a></td>
    <td align="center"><a href="https://github.com/cicelcup"><img src="https://avatars0.githubusercontent.com/u/48078472?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jorge A Peroza M</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3Acicelcup" title="Bug reports">🐛</a> <a href="https://github.com/fluttercommunity/backdrop/commits?author=cicelcup" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/heath3n"><img src="https://avatars0.githubusercontent.com/u/8888204?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Matt Newell</b></sub></a><br /><a href="https://gitlab.com/daadu/backdrop/-/issues?scope=all&utf8=%E2%9C%93&state=all&author_username=heath3n" title="Bug">🐛</a></td>
    <td align="center"><a href="https://danielborges93.com/"><img src="https://avatars0.githubusercontent.com/u/1283243?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Daniel Borges</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3Adanielborges93" title="Bug reports">🐛</a> <a href="https://github.com/fluttercommunity/backdrop/commits?author=danielborges93" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/felixwortmann"><img src="https://avatars0.githubusercontent.com/u/45035656?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Felix Wortmann</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=felixwortmann" title="Code">💻</a> <a href="https://github.com/fluttercommunity/backdrop/pulls?q=is%3Apr+reviewed-by%3Afelixwortmann" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3Afelixwortmann" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/pgrimaud"><img src="https://avatars0.githubusercontent.com/u/1866496?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Pierre Grimaud</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=pgrimaud" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/vlytvyne"><img src="https://avatars0.githubusercontent.com/u/44924680?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Вадим</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=vlytvyne" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/iLDA1997"><img src="https://avatars0.githubusercontent.com/u/27288368?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Danial Agh</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3AiLDA1997" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/PembaTamang"><img src="https://avatars0.githubusercontent.com/u/32651212?v=4?s=100" width="100px;" alt=""/><br /><sub><b>PembaTamang</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3APembaTamang" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/hassanbasanjide"><img src="https://avatars0.githubusercontent.com/u/58950648?v=4?s=100" width="100px;" alt=""/><br /><sub><b>hassan</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3Ahassanbasanjide" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://www.proninyaroslav.ru/"><img src="https://avatars0.githubusercontent.com/u/7840559?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Yaroslav Pronin</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3Aproninyaroslav" title="Bug reports">🐛</a> <a href="https://github.com/fluttercommunity/backdrop/commits?author=proninyaroslav" title="Code">💻</a> <a href="https://github.com/fluttercommunity/backdrop/pulls?q=is%3Apr+reviewed-by%3Aproninyaroslav" title="Reviewed Pull Requests">👀</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/kannel-outis"><img src="https://avatars0.githubusercontent.com/u/32224274?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Enikuomehin Adejuwon</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=kannel-outis" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/farmery"><img src="https://avatars0.githubusercontent.com/u/56759256?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Nwachi ifeanyichukwu Victor</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=farmery" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/mockturtl"><img src="https://avatars0.githubusercontent.com/u/705804?v=4?s=100" width="100px;" alt=""/><br /><sub><b>mockturtl</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=mockturtl" title="Code">💻</a> <a href="https://github.com/fluttercommunity/backdrop/commits?author=mockturtl" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/rtr-dnd"><img src="https://avatars0.githubusercontent.com/u/19490811?v=4?s=100" width="100px;" alt=""/><br /><sub><b>ritar</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3Artr-dnd" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/LorenzoVianello"><img src="https://avatars0.githubusercontent.com/u/32164824?v=4?s=100" width="100px;" alt=""/><br /><sub><b>LorenzoVianello</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/issues?q=author%3ALorenzoVianello" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/ScottMacDougall"><img src="https://avatars0.githubusercontent.com/u/1026653?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Scott</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=ScottMacDougall" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/sachin-dahal"><img src="https://avatars.githubusercontent.com/u/56621935?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Sachin Dahal</b></sub></a><br /><a href="https://github.com/fluttercommunity/backdrop/commits?author=sachin-dahal" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
