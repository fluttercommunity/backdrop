import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// This class is an InheritedWidget that exposes state of [BackdropScaffold]
/// [BackdropScaffoldState] to be accessed from anywhere below the widget tree.
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
  final BackdropScaffoldState data;

  /// Creates a [Backdrop] instance.
  Backdrop({Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);

  /// Provides access to the state from everywhere in the widget tree.
  static BackdropScaffoldState of(BuildContext context) =>
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

  /// Background [Color] for the back layer.
  ///
  /// Defaults to `Theme.of(context).primaryColor`.
  final Color backLayerBackgroundColor;

  /// Defines the color for the inactive front layer.
  /// A default opacity of 0.7 is applied to the passed color.
  /// See [inactiveOverlayOpacity].
  ///
  /// Defaults to `const Color(0xFFEEEEEE)`.
  final Color inactiveOverlayColor;

  /// The opacity value applied to [inactiveOverlayColor] when used on the
  /// inactive layer.
  ///
  /// The inactive layer overlays the [frontLayer] when the back layer is
  /// revealed and the front layer is in a concealed state.
  ///
  /// Must be a value between `0.0` and `1.0`.
  /// Defaults to `0.7`.
  final double inactiveOverlayOpacity;

  /// Will be called when [backLayer] have been concealed.
  final VoidCallback onBackLayerConcealed;

  /// Will be called when [backLayer] have been revealed.
  final VoidCallback onBackLayerRevealed;

  // ------------- PROPERTIES TAKEN OVER FROM SCAFFOLD ------------- //

  /// See [Scaffold.appBar].
  final PreferredSizeWidget appBar;

  /// See [Scaffold.extendBody].
  ///
  /// Defaults to `false`.
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  ///
  /// Defaults to `false`.
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.floatingActionButton].
  final Widget floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  final FloatingActionButtonLocation floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  final FloatingActionButtonAnimator floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget> persistentFooterButtons;

  /// See [Scaffold.drawer].
  final Widget drawer;

  /// See [Scaffold.endDrawer].
  final Widget endDrawer;

  /// See [Scaffold.drawerScrimColor].
  final Color drawerScrimColor;

  /// See [Scaffold.backgroundColor].
  final Color backgroundColor;

  /// See [Scaffold.bottomNavigationBar].
  final Widget bottomNavigationBar;

  /// See [Scaffold.bottomSheet].
  final Widget bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  ///
  /// Defaults to `true`.
  final bool resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  ///
  /// Defaults to `true`.
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior].
  ///
  /// Defaults to `DragStartBehavior.start`.
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  ///
  /// Defaults to `true`.
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  ///
  /// Defaults to `true`.
  final bool endDrawerEnableOpenDragGesture;

  /// Creates a backdrop scaffold to be used as a material widget.
  BackdropScaffold({
    Key key,
    this.controller,
    @Deprecated("Replace by use of BackdropAppBar. See BackdropAppBar.title."
        "This feature was deprecated after v0.2.17.")
        this.title,
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
    this.backLayerBackgroundColor,
    this.inactiveOverlayColor = const Color(0xFFEEEEEE),
    this.inactiveOverlayOpacity = 0.7,
    this.onBackLayerConcealed,
    this.onBackLayerRevealed,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
  })  : assert(inactiveOverlayOpacity >= 0.0 && inactiveOverlayOpacity <= 1.0),
        super(key: key);

  @override
  BackdropScaffoldState createState() => BackdropScaffoldState();
}

/// This class is used to represent the internal state of [BackdropScaffold].
/// It provides access to the functionality for triggering backdrop. As well it
/// offers ways to retrieve the current state of the [BackdropScaffold]'s front-
/// or back layers (concealed/revealed).
///
/// An instance of this class is automatically created with the use of
/// [BackdropScaffold] and can be accessed using `Backdrop.of(context)` from
/// within the widget tree below [BackdropScaffold].
class BackdropScaffoldState extends State<BackdropScaffold>
    with SingleTickerProviderStateMixin {
  bool _shouldDisposeController = false;
  AnimationController _controller;

  /// Key for accessing the [ScaffoldState] of [BackdropScaffold]'s internally
  /// used [Scaffold].
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double _backPanelHeight = 0;
  double _subHeaderHeight = 0;

  /// [AnimationController] used for the backdrop animation.
  ///
  /// Defaults to
  /// ```dart
  /// AnimationController(
  ///         vsync: this, duration: Duration(milliseconds: 200), value: 1.0)
  /// ```
  AnimationController get controller => _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
            vsync: this, duration: Duration(milliseconds: 200), value: 1.0);
    if (widget.controller == null) _shouldDisposeController = true;

    _controller.addStatusListener((status) {
      setState(() {
        // This is intentionally left empty. The state change itself takes
        // place inside the AnimationController, so there's nothing to update.
        // All we want is for the widget to rebuild and read the new animation
        // state from the AnimationController.
        // see https://github.com/flutter/flutter/pull/55414/commits/72d7d365be6639271a5e88ee3043b92833facb79
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_shouldDisposeController) _controller.dispose();
  }

  /// Deprecated. Use [isBackLayerConcealed] instead.
  ///
  /// Wether the back layer is concealed or not.
  @Deprecated("Replace by the use of `isBackLayerConcealed`."
      "This feature was deprecated after v0.3.2.")
  bool get isTopPanelVisible => isBackLayerConcealed;

  /// Wether the back layer is concealed or not.
  bool get isBackLayerConcealed =>
      controller.status == AnimationStatus.completed ||
      controller.status == AnimationStatus.forward;

  /// Deprecated. Use [isBackLayerRevealed] instead.
  ///
  /// Whether the back layer is revealed or not.
  @Deprecated("Replace by the use of `isBackLayerRevealed`."
      "This feature was deprecated after v0.3.2.")
  bool get isBackPanelVisible => isBackLayerRevealed;

  /// Whether the back layer is revealed or not.
  bool get isBackLayerRevealed =>
      controller.status == AnimationStatus.dismissed ||
      controller.status == AnimationStatus.reverse;

  /// Toggles the backdrop functionality.
  ///
  /// If the back layer was concealed, it is animated to the "revealed" state
  /// by this function. If it was revealed, this function will animate it to
  /// the "concealed" state.
  void fling() {
    FocusScope.of(context)?.unfocus();
    if (isBackLayerConcealed) {
      revealBackLayer();
    } else {
      concealBackLayer();
    }
  }

  /// Deprecated. Use [revealBackLayer] instead.
  ///
  /// Animates the back layer to the "revealed" state.
  @Deprecated("Replace by the use of `revealBackLayer`."
      "This feature was deprecated after v0.3.2.")
  void showBackLayer() => revealBackLayer();

  /// Animates the back layer to the "revealed" state.
  void revealBackLayer() {
    if (isBackLayerConcealed) {
      controller.animateBack(-1.0);
      widget.onBackLayerRevealed?.call();
    }
  }

  /// Deprecated. Use [concealBackLayer] instead.
  ///
  /// Animates the back layer to the "concealed" state.
  @Deprecated("Replace by the use of `concealBackLayer`."
      "This feature was deprecated after v0.3.2.")
  void showFrontLayer() => concealBackLayer();

  /// Animates the back layer to the "concealed" state.
  void concealBackLayer() {
    if (isBackLayerRevealed) {
      controller.animateTo(1.0);
      widget.onBackLayerConcealed?.call();
    }
  }

  double get _headerHeight {
    // if defined then use it
    if (widget.headerHeight != null) return widget.headerHeight;

    // if no subHeader then 32.0
    if (widget.subHeader == null) return 32.0;

    // if subHeader then height of subHeader
    return _subHeaderHeight;
  }

  Animation<RelativeRect> _getPanelAnimation(
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
                  color: widget.inactiveOverlayColor
                      .withOpacity(widget.inactiveOverlayOpacity),
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
              child: _MeasureSize(
                onChange: (size) =>
                    setState(() => _backPanelHeight = size.height),
                child: widget.backLayer ?? Container(),
              ),
            ),
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
                _MeasureSize(
                  onChange: (size) =>
                      setState(() => _subHeaderHeight = size.height),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle1,
                    child: widget.subHeader ?? Container(),
                  ),
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
                    rect: _getPanelAnimation(context, constraints),
                    child: _buildFrontPanel(context),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        drawerDragStartBehavior: widget.drawerDragStartBehavior,
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        drawerScrimColor: widget.drawerScrimColor,
        drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
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

typedef void _OnWidgetSizeChange(Size size);

/// Widget to get size of child widget
/// Credit: https://stackoverflow.com/a/60868972/2554745
class _MeasureSize extends StatefulWidget {
  final Widget child;
  final _OnWidgetSizeChange onChange;

  const _MeasureSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  final widgetKey = GlobalKey();
  Size oldSize;

  void _notify() {
    final context = widgetKey.currentContext;
    if (context == null) return;

    final newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => _notify());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        SchedulerBinding.instance.addPostFrameCallback((_) => _notify());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: widgetKey,
          child: widget.child,
        ),
      ),
    );
  }
}
