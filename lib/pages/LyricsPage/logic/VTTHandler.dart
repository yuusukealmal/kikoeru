// class
import "package:kikoeru/class/Lyrics/VTTClass.dart";

List<VttClass> getVTTClass(String content) {
  final lines = content.split("\n");
  final List<VttClass> subtitles = [];

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
        subtitles.add(VttClass(VttString: (times, text.trim())));
      }
    }
  }

  return subtitles;
}

String getCurrentSubtitle(Duration currentPosition, List<VttClass> subtitles) {
  for (int i = 0; i < subtitles.length; i++) {
    if (currentPosition >= subtitles[i].start &&
        currentPosition <= subtitles[i].end) {
      return subtitles[i].text;
    }
  }
  return "";
}
