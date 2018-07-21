library backdrop;

import 'package:flutter/material.dart';

class BackdropScaffold extends StatefulWidget {
  final AnimationController controller;
  final Widget title;
  final Widget backpanel;
  final Widget body;
  final List<Widget> actions;

  BackdropScaffold({
    this.controller,
    this.title,
    this.backpanel,
    this.body,
    this.actions,
  });

  @override
  _BackdropScaffoldState createState() => _BackdropScaffoldState();
}

class _BackdropScaffoldState extends State<BackdropScaffold> with SingleTickerProviderStateMixin{
  static const header_height = 32.0;
  bool shouldDisposeController = false;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      shouldDisposeController = true;
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
    }else{
      _controller = widget.controller;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(shouldDisposeController) {
      _controller.dispose();
    }
  }

  bool get isTopPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  bool get isBackPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.dismissed ||
        status == AnimationStatus.reverse;
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -backPanelHeight;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  Widget _buildInactiveLayer() {
    return isBackPanelVisible
        ? GestureDetector(
      onTap: () => _controller.fling(velocity: 1.0),
      behavior: HitTestBehavior.opaque,
      child: Center(),
    )
        : const SizedBox(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _buildBackPanel() {
    return Material(
      color: Theme.of(context).primaryColor,
      child: widget.backpanel,
    );
  }

  Widget _buildFrontPanel() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: isBackPanelVisible ? 0.85 : 1.0,
      child: Material(
        elevation: 12.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        child: Stack(
          children: <Widget>[
            widget.body,
            _buildInactiveLayer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        actions: widget.actions,
        elevation: 0.0,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _controller.view,
          ),
          onPressed: () => _controller.fling(
            velocity: isTopPanelVisible ? -1.0 : 1.0,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Stack(
              children: <Widget>[
                _buildBackPanel(),
                PositionedTransition(
                  rect: getPanelAnimation(constraints),
                  child: _buildFrontPanel(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}