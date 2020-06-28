import 'package:demo/data/use_case.dart';
import 'package:demo/data/use_cases/contextual_info/contextual_info.dart';

/// Contextual info use case description.
class ContextualInfoUseCase extends UseCase {
  /// Creates a ContextualInfo use case instance
  ContextualInfoUseCase() {
    name = "Contextual Info";
    description =
        "The backdrop's back layer can be used to show contextual information "
        "in addition to the content shown on the front layer.";
    codeFile = "lib/data/use_cases/contextual_info/contextual_info.dart";
    preview = ContextualInfo();
  }
}
