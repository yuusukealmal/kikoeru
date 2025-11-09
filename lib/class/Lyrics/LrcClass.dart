// utils
import 'package:kikoeru/core/utils/DurationCalc.dart';

class LrcClass {
  static RegExp isLrcRegex = RegExp(r"^(?:\[\d{2}:\d{2}\.\d{2,3}\])+");
  static RegExp lyricRegex = RegExp(r"^(?:\[\d{2}:\d{2}\.\d{2,3}\])+(.*)$");

  LrcClass.fromString(String text) {
    String t = isLrcRegex.firstMatch(text)!.group(0)!;
    Duration time = display2Duration(
      LyricType.LRC,
      t.substring(1, t.length - 1),
    );
    String lyric = lyricRegex.firstMatch(text)!.group(1)!;

    time = time;
    text = lyric;
  }

  late final Duration time;
  late final String text;
}
