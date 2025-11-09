// utils
import "package:kikoeru/core/utils/DurationCalc.dart";

class VttClass {
  static const String segment = "-->";

  VttClass.fromTuple((String, String) text) {
    var parts = text.$1.split(segment);
    Duration start = display2Duration(LyricType.VTT, parts[0].trim());
    Duration end = display2Duration(LyricType.VTT, parts[1].trim());
    String lyric = text.$2;

    start = start;
    end = end;
    lyric = lyric;
  }

  late final Duration start;
  late final Duration end;
  late final String lyric;
}
