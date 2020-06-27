import 'package:flutter/cupertino.dart';

/// Class for showing a preview of the given use case as an actual widget.
class Preview extends StatelessWidget {
  /// The preview widget that is shown within the preview area.
  Widget preview;

  /// Creates an instance of [Preview].
  Preview(this.preview);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          child: preview),
    );
  }
}
