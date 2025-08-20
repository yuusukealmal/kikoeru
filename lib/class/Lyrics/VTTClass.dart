// utils
import "package:kikoeru/core/utils/DurationCalc.dart";

class VttClass {
  static const String segment = "-->";

  VttClass({required this.VttString}) {
    var parts = VttString.$1.split(segment);
    start = display2Duration(LyricType.VTT, parts[0].trim());
    end = display2Duration(LyricType.VTT, parts[1].trim());

    text = VttString.$2;
  }

  final (String, String) VttString;
  late final Duration start;
  late final Duration end;
  late final String text;
}
