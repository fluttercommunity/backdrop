import 'package:demo/data/use_case.dart';
import 'package:demo/data/use_cases/navigation/navigation.dart';

class NavigationUseCase extends UseCase {
  /// Creates a Navigation use case instance
  NavigationUseCase() {
    name = "Navigation";
    description = """
    Backdrop can be used for navigating between different front layers.
    The back layer shows the navigation options and upon selecting any one,
    the front layer changes its content.""";
    codeFile = "lib/data/use_cases/navigation/navigation.dart";
    preview = Navigation();
  }
}
