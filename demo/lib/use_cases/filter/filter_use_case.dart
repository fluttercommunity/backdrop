import 'package:demo/data/use_case.dart';
import 'package:demo/use_cases/filter/filter.dart';

/// Filter use case description.
class FilterUseCase extends UseCase {
  /// Creates a Filter use case instance
  FilterUseCase() {
    name = "Filter";
    description =
        "The backdrop's back layer can be used to filter the content displayed "
        "on the front layer.";
    codeFile = "lib/use_cases/filter/filter.dart";
    preview = Filter();
  }
}
