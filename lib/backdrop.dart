library backdrop;

import 'dart:async';

import 'package:flutter/material.dart';

/// This class is an InheritedWidget that exposes state of [BackdropScaffold]
/// [_BackdropScaffoldState] to be accessed from anywhere below the widget tree.
///
/// It can be used to explicitly call backdrop functionality like fling,
/// concealBackLayer, revealBackLayer, etc.
///
/// Example:
/// ```dart
/// Backdrop.of(context).fling();
/// ```
class Backdrop extends InheritedWidget {
  /// Holds the state of this widget.
  final _BackdropScaffoldState data;

  /// Creates a [Backdrop] instance.
  Backdrop({Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);

  /// Provides access to the state from everywhere in the widget tree.
  static _BackdropScaffoldState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Backdrop>().data;

  @override
  bool updateShouldNotify(Backdrop old) => true;
}

/// Implements the basic functionality of backdrop.
///
/// This class internally uses [Scaffold]. It allows to set a back layer and a
/// front layer and manage the switching between the two. The implementation is
/// inspired by the
/// [material backdrop component](https://material.io/components/backdrop/).
///
/// Usage example:
/// ```dart
/// Widget build(BuildContext context) {
///   return MaterialApp(
///     title: 'Backdrop Demo',
///     home: BackdropScaffold(
///       appBar: BackdropAppBar(
///         title: Text("Backdrop Example"),
///         actions: <Widget>[
///           BackdropToggleButton(
///             icon: AnimatedIcons.list_view,
///           )
///         ],
///       ),
///       backLayer: Center(
///         child: Text("Back Layer"),
///       ),
///       frontLayer: Center(
///         child: Text("Front Layer"),
///       ),
///     ),
///   );
/// }
/// ```
///
/// See also:
///  * [Scaffold], which is the plain scaffold used in material apps.
class BackdropScaffold extends StatefulWidget {
  /// Can be used to customize the behaviour of the backdrop animation.
  final AnimationController controller;

  /// Deprecated. Use [BackdropAppBar.title].
  ///
  /// The widget assigned to the [Scaffold]'s [AppBar.title].
  final Widget title;

  /// App bar used for [BackdropScaffold].
  final PreferredSizeWidget appBar;

  /// Content that should be displayed on the back layer.
  final Widget backLayer;

  /// The widget that is shown on the front layer.
  final Widget frontLayer;

  /// The widget that is shown as sub-header on top of the front layer.
  final Widget subHeader;

  /// This boolean flag keeps subHeader active when [backLayer] is visible. Defaults to true.
  final bool subHeaderAlwaysActive;

  /// Deprecated. Use [BackdropAppBar.actions].
  ///
  /// Actions passed to [AppBar.actions].
  final List<Widget> actions;

  /// Defines the height of the front layer when it is in the opened state.
  ///
  /// This height value is only applied, if [stickyFrontLayer]
  /// is set to `false` or if [stickyFrontLayer] is set to `true` and the back
  /// layer's height is less than
  /// [BoxConstraints.biggest.height]-[headerHeight].
  ///
  /// [headerHeight] is interpreted as the height of the front layer's visible
  /// part, when being opened. The back layer's height corresponds to
  /// [BoxConstraints.biggest.height]-[headerHeight].
  ///
  ///
  /// If [subHeader] is defined then height of subHeader otherwise defaults to 32.0.
  final double headerHeight;

  /// Defines the [BorderRadius] applied to the front layer.
  ///
  /// Defaults to
  /// ```dart
  /// const BorderRadius.only(
  ///     topLeft: Radius.circular(16.0),
  ///     topRight: Radius.circular(16.0),
  /// )
  /// ```
  final BorderRadius frontLayerBorderRadius;

  /// Deprecated. Use [BackdropAppBar]'s properties [BackdropAppBar.leading] and
  /// [BackdropAppBar.automaticallyImplyLeading] to achieve the same behaviour.
  ///
  /// The position of the icon button that toggles the backdrop functionality.
  ///
  /// Defaults to [BackdropIconPosition.leading].
  final BackdropIconPosition iconPosition;

  /// A flag indicating whether the front layer should stick to the height of
  /// the back layer when being opened.
  ///
  /// Defaults to `false`.
  final bool stickyFrontLayer;

  /// The animation curve passed to [Tween.animate]() when triggering
  /// the backdrop animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve animationCurve;

  /// Passed to the [Scaffold] underlying [BackdropScaffold].
  /// See [Scaffold.resizeToAvoidBottomInset].
  ///
  /// Defaults to `true`.
  final bool resizeToAvoidBottomInset;

  /// Background [Color] for the back layer.
  ///
  /// Defaults to `Theme.of(context).primaryColor`.
  final Color backLayerBackgroundColor;

  /// [FloatingActionButton] for the [Scaffold]
  ///
  /// Defaults to `null` which leads the [Scaffold] without a [FloatingActionButton].
  final Widget floatingActionButton;

  /// [FloatingActionButtonLocation] for the [FloatingActionButton] in the [Scaffold]
  ///
  /// Defaults to `null` which leads Scaffold to use the default [FloatingActionButtonLocation]
  final FloatingActionButtonLocation floatingActionButtonLocation;

  /// [FloatingActionButtonAnimator] for the [FloatingActionButton] in the [Scaffold]
  ///
  /// Defaults to `null` which leads Scaffold to use the default [FloatingActionButtonAnimator]
  final FloatingActionButtonAnimator floatingActionButtonAnimator;

  /// Defines the color for the inactive front layer.
  /// Implicitly an opacity of 0.7 is applied to the passed color.
  ///
  /// Defaults to `const Color(0xFFEEEEEE)`.
  final Color inactiveOverlayColor;

  /// Will be called when [backLayer] have been concealed.
  final VoidCallback onBackLayerConcealed;

  /// Will be called when [backLayer] have been revealed.
  final VoidCallback onBackLayerRevealed;

  /// Creates a backdrop scaffold to be used as a material widget.
  BackdropScaffold({
    this.controller,
    @Deprecated("Replace by use of BackdropAppBar. See BackdropAppBar.title."
        "This feature was deprecated after v0.2.17.")
        this.title,
    this.appBar,
    this.backLayer,
    this.frontLayer,
    this.subHeader,
    this.subHeaderAlwaysActive = true,
    @Deprecated("Replace by use of BackdropAppBar. See BackdropAppBar.actions."
        "This feature was deprecated after v0.2.17.")
        this.actions = const <Widget>[],
    this.headerHeight,
    this.frontLayerBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    ),
    @Deprecated("Replace by use of BackdropAppBar. See BackdropAppBar.leading"
        "and BackdropAppBar.automaticallyImplyLeading."
        "This feature was deprecated after v0.2.17.")
        this.iconPosition = BackdropIconPosition.leading,
    this.stickyFrontLayer = false,
    this.animationCurve = Curves.easeInOut,
    this.resizeToAvoidBottomInset = true,
    this.backLayerBackgroundColor,
    this.floatingActionButton,
    this.inactiveOverlayColor = const Color(0xFFEEEEEE),
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.onBackLayerConcealed,
    this.onBackLayerRevealed,
  });

  @override
  _BackdropScaffoldState createState() => _BackdropScaffoldState();
}

class _BackdropScaffoldState extends State<BackdropScaffold>
    with SingleTickerProviderStateMixin {
  bool _shouldDisposeController = false;
  AnimationController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _backLayerKey = GlobalKey(debugLabel: "backdrop:backLayer");
  double _backPanelHeight = 0;
  GlobalKey _subHeaderKey = GlobalKey(debugLabel: "backdrop:subHeader");
  double _headerHeight = 0;

  AnimationController get controller => _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _shouldDisposeController = true;
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 200), value: 1.0);
    } else {
      _controller = widget.controller;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _backPanelHeight = _getBackPanelHeight();
        _headerHeight = _getHeaderHeight();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_shouldDisposeController) _controller.dispose();
  }

  @Deprecated("Replace by the use of `isBackLayerConcealed`."
      "This feature was deprecated after v0.3.2.")
  bool get isTopPanelVisible => isBackLayerConcealed;

  bool get isBackLayerConcealed =>
      controller.status == AnimationStatus.completed ||
      controller.status == AnimationStatus.forward;

  @Deprecated("Replace by the use of `isBackLayerRevealed`."
      "This feature was deprecated after v0.3.2.")
  bool get isBackPanelVisible => isBackLayerRevealed;

  bool get isBackLayerRevealed =>
      controller.status == AnimationStatus.dismissed ||
      controller.status == AnimationStatus.reverse;

  void fling() {
    FocusScope.of(context)?.unfocus();
    if (isBackLayerConcealed) {
      revealBackLayer();
    } else {
      concealBackLayer();
    }
  }

  @Deprecated("Replace by the use of `revealBackLayer`."
      "This feature was deprecated after v0.3.2.")
  void showBackLayer() => revealBackLayer();

  void revealBackLayer() {
    if (isBackLayerConcealed) {
      controller.animateBack(-1.0);
      widget.onBackLayerRevealed?.call();
    }
  }

  @Deprecated("Replace by the use of `concealBackLayer`."
      "This feature was deprecated after v0.3.2.")
  void showFrontLayer() => concealBackLayer();

  void concealBackLayer() {
    if (isBackLayerRevealed) {
      controller.animateTo(1.0);
      widget.onBackLayerConcealed?.call();
    }
  }

  double _getHeaderHeight() {
    // if defined then use it
    if (widget.headerHeight != null) return widget.headerHeight;

    // if no subHeader then 32.0
    if (widget.subHeader == null) return 32.0;

    // if subHeader then height of subHeader
    return ((_subHeaderKey.currentContext?.findRenderObject() as RenderBox)
            ?.size
            ?.height) ??
        32.0;
  }

  double _getBackPanelHeight() =>
      ((_backLayerKey.currentContext?.findRenderObject() as RenderBox)
          ?.size
          ?.height) ??
      0.0;

  Animation<RelativeRect> getPanelAnimation(
      BuildContext context, BoxConstraints constraints) {
    double backPanelHeight, frontPanelHeight;

    if (widget.stickyFrontLayer &&
        _backPanelHeight < constraints.biggest.height - _headerHeight) {
      // height is adapted to the height of the back panel
      backPanelHeight = _backPanelHeight;
      frontPanelHeight = -_backPanelHeight;
    } else {
      // height is set to fixed value defined in widget.headerHeight
      final height = constraints.biggest.height;
      backPanelHeight = height - _headerHeight;
      frontPanelHeight = -backPanelHeight;
    }
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: widget.animationCurve,
    ));
  }

  Widget _buildInactiveLayer(BuildContext context) {
    return Offstage(
      offstage: controller.status == AnimationStatus.completed,
      child: FadeTransition(
        opacity: Tween(begin: 1.0, end: 0.0).animate(controller),
        child: GestureDetector(
          onTap: () => fling(),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: <Widget>[
              // if subHeaderAlwaysActive then do not apply inactiveOverlayColor for area with _headerHeight
              widget.subHeader != null && widget.subHeaderAlwaysActive
                  ? Container(height: _headerHeight)
                  : Container(),
              Expanded(
                child: Container(
                  color: widget.inactiveOverlayColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackPanel() {
    return FocusScope(
      canRequestFocus: isBackLayerRevealed,
      child: Material(
        color: this.widget.backLayerBackgroundColor ??
            Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Flexible(
                key: _backLayerKey, child: widget.backLayer ?? Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontPanel(BuildContext context) {
    return Material(
      elevation: 1.0,
      borderRadius: widget.frontLayerBorderRadius,
      child: ClipRRect(
        borderRadius: widget.frontLayerBorderRadius,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // subHeader
                DefaultTextStyle(
                  key: _subHeaderKey,
                  style: Theme.of(context).textTheme.subtitle1,
                  child: widget.subHeader ?? Container(),
                ),
                // frontLayer
                Flexible(child: widget.frontLayer),
              ],
            ),
            _buildInactiveLayer(context),
          ],
        ),
      ),
    );
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    if (isBackLayerRevealed) {
      concealBackLayer();
      return null;
    }
    return true;
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButtonLocation: this.widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: this.widget.floatingActionButtonAnimator,
        appBar: widget.appBar ??
            AppBar(
              title: widget.title,
              actions: widget.iconPosition == BackdropIconPosition.action
                  ? <Widget>[BackdropToggleButton()] + widget.actions
                  : widget.actions,
              elevation: 0.0,
              leading: widget.iconPosition == BackdropIconPosition.leading
                  ? BackdropToggleButton()
                  : null,
            ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              child: Stack(
                children: <Widget>[
                  _buildBackPanel(),
                  PositionedTransition(
                    rect: getPanelAnimation(context, constraints),
                    child: _buildFrontPanel(context),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: this.widget.floatingActionButton,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      data: this,
      child: Builder(
        builder: (context) => _buildBody(context),
      ),
    );
  }
}

/// An animated button that can be used to trigger the backdrop functionality of
/// [BackdropScaffold].
///
/// This button is implicitly used within [BackdropAppBar].
/// This button can also be passed to the [BackdropAppBar.actions].
///
/// When being pressed, [BackdropToggleButton] looks for a [Backdrop] instance
/// above it in the widget tree and toggles its opening/closing.
///
/// Example:
/// ```dart
/// Widget build(BuildContext context) {
///   return MaterialApp(
///     title: 'Backdrop Demo',
///     home: BackdropScaffold(
///       ...
///       actions: <Widget>[
///         BackdropToggleButton(
///           icon: AnimatedIcons.list_view,
///         ),
///       ],
///     ),
///   );
/// }
/// ```
class BackdropToggleButton extends StatelessWidget {
  /// Animated icon that is used for the contained [AnimatedIcon].
  ///
  /// Defaults to [AnimatedIcons.close_menu].
  final AnimatedIconData icon;

  /// Creates an instance of [BackdropToggleButton].
  const BackdropToggleButton({
    this.icon = AnimatedIcons.close_menu,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: icon,
        progress: Backdrop.of(context).controller.view,
      ),
      onPressed: () => Backdrop.of(context).fling(),
    );
  }
}

/// Deprecated. Not needed anymore when [BackdropAppBar] is used.
///
/// This enum is used to specify where [BackdropToggleButton] should appear
/// within [AppBar].
@Deprecated("Replace by the use of BackdropAppBar."
    "This feature was deprecated after v0.2.17.")
enum BackdropIconPosition {
  /// Indicates that [BackdropToggleButton] should not appear at all.
  none,

  /// Indicates that [BackdropToggleButton] should appear at the start of
  /// [AppBar].
  leading,

  /// Indicates that [BackdropToggleButton] should appear as an action within
  /// [AppBar.actions].
  action
}

/// A material app bar that offers functionality for triggering the
/// [BackdropScaffold]'s functionality. It is internally implemented using the
/// [AppBar] class.
///
/// What differs from the [AppBar] implementation is the behaviour of
/// [BackdropScaffold.leading] and [BackdropScaffold.automaticallyImplyLeading].
///
/// Usage example:
/// ```dart
/// Widget build(BuildContext context) {
///   return MaterialApp(
///     title: 'Backdrop Demo',
///     home: BackdropScaffold(
///       appBar: BackdropAppBar(
///         title: Text("Backdrop Example"),
///         actions: <Widget>[
///           BackdropToggleButton(
///             icon: AnimatedIcons.list_view,
///           )
///         ],
///       ),
///       ...
///     ),
///   );
/// }
/// ```
///
/// See also:
///  * [AppBar], which is the plain app bar used in material apps.
class BackdropAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// See [AppBar.leading].
  ///
  /// If this is `null` and if [BackdropAppBar.automaticallyImplyLeading] is
  /// set to `true`, [BackdropAppBar] sets the underlying [AppBar.leading] to
  /// [BackdropToggleButton].
  final Widget leading;

  /// See [AppBar.automaticallyImplyLeading].
  ///
  /// If this is set to `true` and [BackdropAppBar.leading] is set to `null`,
  /// [BackdropAppBar] automatically sets the underlying [AppBar.leading]
  /// to [BackdropToggleButton].
  ///
  /// Defaults to `true`.
  final bool automaticallyImplyLeading;

  /// The widget that should be displayed as the [AppBar] title.
  final Widget title;

  /// See [AppBar.actions].
  final List<Widget> actions;

  /// See [AppBar.flexibleSpace].
  final Widget flexibleSpace;

  /// See [AppBar.bottom].
  final PreferredSizeWidget bottom;

  /// See [AppBar.elevation].
  ///
  /// Defaults to 0.0. This differs from [AppBar.elevation].
  final double elevation;

  /// See [AppBar.shape]
  final ShapeBorder shape;

  /// See [AppBar.backgroundColor].
  final Color backgroundColor;

  /// See [AppBar.brightness].
  final Brightness brightness;

  /// See [AppBar.iconTheme].
  final IconThemeData iconTheme;

  /// See [AppBar.actionsIconTheme].
  final IconThemeData actionsIconTheme;

  /// See [AppBar.textTheme].
  final TextTheme textTheme;

  /// See [AppBar.primary].
  final bool primary;

  /// See [AppBar.centerTitle].
  final bool centerTitle;

  /// See [AppBar.excludeHeaderSemantics].
  final bool excludeHeaderSemantics;

  /// See [AppBar.iconTheme].titleSpacing
  final double titleSpacing;

  /// See [AppBar.toolbarOpacity].
  final double toolbarOpacity;

  /// See [AppBar.bottomOpacity].
  final double bottomOpacity;

  /// See [AppBar.preferredSize].
  @override
  final Size preferredSize;

  /// Creates a backdrop app bar.
  ///
  /// For more information see [AppBar].
  BackdropAppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 0.0,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : assert(automaticallyImplyLeading != null),
        assert(elevation == null || elevation >= 0.0),
        assert(primary != null),
        assert(titleSpacing != null),
        assert(toolbarOpacity != null),
        assert(bottomOpacity != null),
        preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          (automaticallyImplyLeading ? BackdropToggleButton() : null),
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shape: shape,
      backgroundColor: backgroundColor,
      brightness: brightness,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: textTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
    );
  }
}

/// A wrapper for adding a sub-header to the used backdrop front layer(s).
/// This class can be passed to [BackdropScaffold] to specify the sub-header
/// that should be shown while the front layer is "inactive" (the back layer is
/// "showing").
///
/// Usage example:
/// ```dart
/// BackdropScaffold(
///   appBar: ...,
///   backLayer: ...,
///   subHeader: BackdropSubHeader(
///     title: Text("Sub Header"),
///   ),
///   frontLayer: ...,
/// )
/// ```
class BackdropSubHeader extends StatelessWidget {
  /// The primary content of the sub-header.
  final Widget title;

  /// The divider that should be shown at the bottom of the sub-header.
  ///
  /// Defaults to `Divider(height: 4.0, indent: 16.0, endIndent: 16.0)`.
  final Widget divider;

  /// Padding that will be applied to the sub-header.
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)`.
  final EdgeInsets padding;

  /// Flag indicating whether the leading widget for the sub-header should be
  /// automatically determined by [BackdropSubHeader].
  ///
  /// If set to `true`, a leading `Icon(Icons.keyboard_arrow_up)` is added to
  /// the sub-header.
  ///
  /// Defaults to `false`.
  final bool automaticallyImplyLeading;

  /// Flag indicating whether the trailing widget for the sub-header should be
  /// automatically determined by [BackdropSubHeader].
  ///
  /// If set to `true`, a trailing `Icon(Icons.keyboard_arrow_up)` is added to
  /// the sub-header.
  ///
  /// Defaults to `true`.
  final bool automaticallyImplyTrailing;

  /// Widget to be shown as leading element to the sub-header. If set, the value
  /// of [automaticallyImplyLeading] is ignored.
  final Widget leading;

  /// Widget to be shown as trailing element to the sub-header. If set, the value
  /// of [automaticallyImplyTrailing] is ignored.
  final Widget trailing;

  /// Creates a [BackdropSubHeader] instance.
  ///
  /// The [title] argument must not be `null`.
  const BackdropSubHeader({
    Key key,
    @required this.title,
    this.divider,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.automaticallyImplyLeading = false,
    this.automaticallyImplyTrailing = true,
    this.leading,
    this.trailing,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildAutomaticLeadingOrTrailing(BuildContext context) =>
        FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0)
              .animate(Backdrop.of(context).controller),
          child: Icon(Icons.keyboard_arrow_up),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: padding,
          child: Row(
            children: <Widget>[
              leading ??
                  (automaticallyImplyLeading
                      ? _buildAutomaticLeadingOrTrailing(context)
                      : Container()),
              Expanded(
                child: title,
              ),
              trailing ??
                  (automaticallyImplyTrailing
                      ? _buildAutomaticLeadingOrTrailing(context)
                      : Container()),
            ],
          ),
        ),
        divider ?? const Divider(height: 4.0, indent: 16.0, endIndent: 16.0),
      ],
    );
  }
}

/// Implements the back layer to be used for navigation.
///
/// This class can be used as a back layer for [BackdropScaffold]. It enables to
/// use the back layer as a navigation list, similar to a [Drawer].
///
/// Usage example:
/// ```dart
/// int _currentIndex = 0;
/// final List<Widget> _pages = [Widget1(), Widget2()];
///
/// @override
/// Widget build(BuildContext context) {
///   return MaterialApp(
///     title: 'Backdrop Demo',
///     home: BackdropScaffold(
///       appBar: BackdropAppBar(
///         title: Text("Navigation Example"),
///         actions: <Widget>[
///           BackdropToggleButton(
///             icon: AnimatedIcons.list_view,
///           )
///         ],
///       ),
///       stickyFrontLayer: true,
///       frontLayer: _pages[_currentIndex],
///       backLayer: BackdropNavigationBackLayer(
///         items: [
///           ListTile(title: Text("Widget 1")),
///           ListTile(title: Text("Widget 2")),
///         ],
///         onTap: (int position) => {setState(() => _currentIndex = position)},
///       ),
///     ),
///   );
/// }
/// ```
class BackdropNavigationBackLayer extends StatelessWidget {
  /// The items to be inserted into the underlying [ListView] of the
  /// [BackdropNavigationBackLayer].
  final List<Widget> items;

  /// Callback that is called whenever a list item is tapped by the user.
  final ValueChanged<int> onTap;

  /// Customizable separator used with [ListView.separated].
  final Widget separator;

  /// Creates an instance of [BackdropNavigationBackLayer] to be used with
  /// [BackdropScaffold].
  ///
  /// The argument [items] is required and must not be `null` and not empty.
  BackdropNavigationBackLayer({
    Key key,
    @required this.items,
    this.onTap,
    this.separator,
  })  : assert(items != null),
        assert(items.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, position) => InkWell(
        child: items[position],
        onTap: () {
          // fling backdrop
          Backdrop.of(context).fling();

          // call onTap function and pass new selected index
          onTap?.call(position);
        },
      ),
      separatorBuilder: (builder, position) => separator ?? Container(),
    );
  }
}
