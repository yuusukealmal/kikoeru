String duration2Display(int duration, {bool isDetail = false}) {
  if (isDetail) {
    int hr = duration ~/ 3600;
    int min = (duration % 3600) ~/ 60;
    int sec = (duration % 3600) % 60;
    return "($hr:$min:$sec)";
  } else {
    int hr = duration ~/ 3600;
    if (hr > 0) {
      return "(${(duration / 3600).toStringAsFixed(1)})hr";
    }
    int min = (duration % 3600) ~/ 60;
    if (min > 0) {
      return "(${min}min)";
    }
    return "(${duration}s)";
  }
}

enum LyricType { VTT, LRC }

Duration display2Duration(LyricType t, String s) {
  switch (t) {
    case LyricType.VTT:
      final parts = s.split(":");
      final hour = int.parse(parts[0]);
      final min = int.parse(parts[1]);
      final second = int.parse(parts[2].split(".")[0]);
      final milisecond = int.parse(parts[2].split(".")[1]);

      return Duration(
        hours: hour,
        minutes: min,
        seconds: second,
        milliseconds: milisecond,
      );

    case LyricType.LRC:
      final parts = s.split(":");
      final min = int.parse(parts[0]);
      final second = int.parse(parts[1].split(".")[0]);
      final milisecond = int.parse(parts[1].split(".")[1]);
      return Duration(
        minutes: min,
        seconds: second,
        milliseconds: milisecond,
      );
  }
}
