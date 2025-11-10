// class
import "package:kikoeru/class/Lyrics/VttClass.dart";
import "package:kikoeru/class/Lyrics/LrcClass.dart";

List<dynamic> getSubTitleClass(String content) {
  final lines = content.split("\n");
  final List<dynamic> subtitles = [];

  bool isLrcFormat = lines.any(
    (line) => LrcClass.isLrcRegex.hasMatch(line.trim()),
  );

  if (isLrcFormat) {
    for (String line in lines) {
      final content = line.trim();
      if (LrcClass.isLrcRegex.hasMatch(content)) {
        subtitles.add(LrcClass.fromString(content));
      }
    }
  } else {
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains("-->")) {
        final times = lines[i];

        String text = "";
        int j = i + 1;
        while (j < lines.length && lines[j].trim().isNotEmpty) {
          text += "${lines[j].trim()}\n";
          j++;
        }
        if (text.trim().isNotEmpty) {
          subtitles.add(VttClass.fromTuple((times, text.trim())));
        }
      }
    }
  }

  return subtitles;
}

String getCurrentSubtitle(Duration currentPosition, List<dynamic> subtitles) {
  for (int i = 0; i < subtitles.length; i++) {
    final subtitle = subtitles[i];

    if (subtitle is VttClass) {
      if (currentPosition >= subtitle.start &&
          currentPosition <= subtitle.end) {
        return subtitle.lyric;
      }
    } else if (subtitle is LrcClass) {
      if (currentPosition >= subtitle.time) {
        if (i == subtitles.length - 1 ||
            (i + 1 < subtitles.length &&
                subtitles[i + 1] is LrcClass &&
                currentPosition < (subtitles[i + 1] as LrcClass).time)) {
          return subtitle.lyric;
        }
      }
    }
  }
  return "";
}
