import 'package:backdrop/button.dart';
import 'package:flutter/material.dart';

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
  final Widget? leading;

  /// See [AppBar.automaticallyImplyLeading].
  ///
  /// If this is set to `true` and [BackdropAppBar.leading] is set to `null`,
  /// [BackdropAppBar] automatically sets the underlying [AppBar.leading]
  /// to [BackdropToggleButton].
  ///
  /// Defaults to `true`.
  final bool automaticallyImplyLeading;

  /// The widget that should be displayed as the [AppBar] title.
  final Widget? title;

  /// See [AppBar.actions].
  final List<Widget>? actions;

  /// See [AppBar.flexibleSpace].
  final Widget? flexibleSpace;

  /// See [AppBar.bottom].
  final PreferredSizeWidget? bottom;

  /// See [AppBar.elevation].
  ///
  /// Defaults to 0.0. This differs from [AppBar.elevation].
  final double elevation;

  /// See [AppBar.shape]
  final ShapeBorder? shape;

  /// See [AppBar.backgroundColor].
  final Color? backgroundColor;

  /// See [AppBar.brightness].
  final Brightness? brightness;

  /// See [AppBar.iconTheme].
  final IconThemeData? iconTheme;

  /// See [AppBar.actionsIconTheme].
  final IconThemeData? actionsIconTheme;

  /// See [AppBar.textTheme].
  final TextTheme? textTheme;

  /// See [AppBar.primary].
  final bool primary;

  /// See [AppBar.centerTitle].
  final bool? centerTitle;

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
    Key? key,
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
  })  : assert(elevation >= 0.0),
        preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          (automaticallyImplyLeading ? const BackdropToggleButton() : null),
      automaticallyImplyLeading: automaticallyImplyLeading,
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
