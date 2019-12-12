library backdrop;

import 'dart:async';

import 'package:flutter/material.dart';

class Backdrop extends InheritedWidget {
  final _BackdropScaffoldState data;

  Backdrop({Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);

  static _BackdropScaffoldState of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Backdrop) as Backdrop).data;

  @override
  bool updateShouldNotify(Backdrop old) => true;
}

class BackdropScaffold extends StatefulWidget {
  final AnimationController controller;
  final Widget title;
  final Widget backLayer;
  final Widget frontLayer;
  final BackdropNavigationBackLayer backdropNavigationBackLayer;
  final List<Widget> actions;
  final double headerHeight;
  final BorderRadius frontLayerBorderRadius;
  final BackdropIconPosition iconPosition;
  final bool enableDynamicBackdropHeight;
  final Curve animationCurve;

  BackdropScaffold({
    this.controller,
    this.title,
    this.backLayer,
    this.frontLayer,
    this.backdropNavigationBackLayer,
    this.actions = const <Widget>[],
    this.headerHeight = 32.0,
    this.frontLayerBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    ),
    this.iconPosition = BackdropIconPosition.leading,
    this.enableDynamicBackdropHeight = false,
    this.animationCurve = Curves.linear,
  })
  // either backLayer or backdropNavigationBackLayer have to be set
  : assert((backLayer != null) ^ (backdropNavigationBackLayer != null));

  @override
  _BackdropScaffoldState createState() => _BackdropScaffoldState();
}

class _BackdropScaffoldState extends State<BackdropScaffold>
    with SingleTickerProviderStateMixin {
  Widget _frontLayer;
  bool shouldDisposeController = false;
  AnimationController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _backLayerKey = GlobalKey();
  double _backPanelHeight = 0;

  AnimationController get controller => _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      shouldDisposeController = true;
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
    } else {
      _controller = widget.controller;
    }

    // we know from assertion that either backLayer or backdropNavigationBackLayer is set
    if (widget.backLayer != null)
      // use frontLayer just like normal
      _frontLayer = widget.frontLayer;
    else
      // use first of the defined front layers of backdropNavigationItems
      _frontLayer = widget
          .backdropNavigationBackLayer.backdropNavigationItems.first.frontLayer;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _backPanelHeight = _getBackPanelHeight();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (shouldDisposeController) {
      _controller.dispose();
    }
  }

  bool get isTopPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  bool get isBackPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.dismissed ||
        status == AnimationStatus.reverse;
  }

  void fling() {
    controller.fling(velocity: isTopPanelVisible ? -1.0 : 1.0);
  }

  void showBackLayer() {
    if (isTopPanelVisible) {
      controller.fling(velocity: -1.0);
    }
  }

  void showFrontLayer() {
    if (isBackPanelVisible) {
      controller.fling(velocity: 1.0);
    }
  }

  double _getBackPanelHeight() {
    RenderBox backLayerRenderBox =
        _backLayerKey.currentContext?.findRenderObject();
    if (backLayerRenderBox != null)
      return backLayerRenderBox.size.height;
    else
      return 0.0;
  }

  Animation<RelativeRect> getPanelAnimation(
      BuildContext context, BoxConstraints constraints) {
    var backPanelHeight, frontPanelHeight;

    if (widget.enableDynamicBackdropHeight) {
      // height is adapted to the height of the back panel
      backPanelHeight = _backPanelHeight;
      frontPanelHeight = -_backPanelHeight;
    } else {
      // height is set to fixed value defined in widget.headerHeight
      final height = constraints.biggest.height;
      backPanelHeight = height - widget.headerHeight;
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
      offstage: isTopPanelVisible,
      child: GestureDetector(
        onTap: () => fling(),
        behavior: HitTestBehavior.opaque,
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.frontLayerBorderRadius,
              color: Colors.grey.shade200.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackPanel() {
    // given the assert in the constructor, either backLayer or
    // backdropNavigationBackLayer is assumed to be set
    var backLayer = widget.backLayer != null
        ? widget.backLayer
        : widget.backdropNavigationBackLayer;

    return Material(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Container(key: _backLayerKey, child: backLayer),
        ],
      ),
    );
  }

  Widget _buildFrontPanel(BuildContext context) {
    return Material(
      elevation: 12.0,
      borderRadius: widget.frontLayerBorderRadius,
      child: Stack(
        children: <Widget>[
          _frontLayer,
          _buildInactiveLayer(context),
        ],
      ),
    );
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    if (isBackPanelVisible) {
      showFrontLayer();
      return null;
    }
    return true;
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
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

class BackdropToggleButton extends StatelessWidget {
  final AnimatedIconData icon;

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

enum BackdropIconPosition { none, leading, action }

class BackdropNavigationItem {
  Widget item;
  Widget frontLayer;

  BackdropNavigationItem({@required this.item, @required this.frontLayer})
      : assert(item != null),
        assert(frontLayer != null);
}

class BackdropNavigationBackLayer extends StatefulWidget {
  final List<BackdropNavigationItem> backdropNavigationItems;
  final ValueChanged<int> onTap;

  BackdropNavigationBackLayer({
    Key key,
    @required this.backdropNavigationItems,
    this.onTap,
  })  : assert(backdropNavigationItems != null),
        assert(backdropNavigationItems.isNotEmpty),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _BackdropNavigationBackLayerState();
}

class _BackdropNavigationBackLayerState
    extends State<BackdropNavigationBackLayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.backdropNavigationItems.length,
          itemBuilder: (context, position) => InkWell(
              child: widget.backdropNavigationItems[position].item,
              onTap: () {
                setState(() {
                  var backdropScaffoldState = Backdrop.of(context);
                  backdropScaffoldState._frontLayer =
                      widget.backdropNavigationItems[position].frontLayer;
                  backdropScaffoldState.fling();
                });

                // call onTap function and pass new selected index
                widget.onTap?.call(position);
              }),
          separatorBuilder: (builder, position) => Divider()),
    );
  }
}
