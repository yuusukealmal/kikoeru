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

Duration display2Duration(String s) {
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
}
