import 'package:demo/data/use_case.dart';
import 'package:demo/use_cases/navigation/navigation.dart';

/// Navigation use case description.
class NavigationUseCase extends UseCase {
  /// Creates a Navigation use case instance
  NavigationUseCase() {
    name = "Navigation";
    description =
        "Backdrop can be used for navigating between different front layers. "
        "The back layer shows the navigation options and upon selecting any "
        "one, the front layer changes its content.";
    codeFile = "lib/use_cases/navigation/navigation.dart";
    preview = Navigation();
  }
}
