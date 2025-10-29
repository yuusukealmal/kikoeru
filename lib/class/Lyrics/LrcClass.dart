// utils
import 'package:kikoeru/core/utils/DurationCalc.dart';

class LrcClass {
  static RegExp isLrc = RegExp(r"^(?:\[\d{2}:\d{2}\.\d{2,3}\])+");
  RegExp lyric = RegExp(r"^(?:\[\d{2}:\d{2}\.\d{2,3}\])+(.*)$");

  LrcClass({required this.LrcText}) {
    String t = isLrc.firstMatch(LrcText)!.group(0)!;
    time = display2Duration(LyricType.LRC, t.substring(1, t.length - 1));
    text = lyric.firstMatch(LrcText)!.group(1)!;
  }

  final String LrcText;
  late final Duration time;
  late final String text;
}
