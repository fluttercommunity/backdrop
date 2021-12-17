import 'package:demo/data/use_case.dart';
import 'package:demo/use_cases/contextual_controls/contextual_controls.dart';

/// Contextual controls use case description.
class ContextualControlsUseCase extends UseCase {
  /// Creates a ContextualControls use case instance
  ContextualControlsUseCase() {
    name = "Contextual Controls";
    description =
        "The backdrop's back layer can be used to control the content that is being "
        "shown on the front layer.";
    codeFile = "lib/use_cases/contextual_controls/contextual_controls.dart";
    preview = const ContextualControls();
  }
}
