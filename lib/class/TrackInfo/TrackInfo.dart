// class
import "package:kikoeru/class/TrackInfo/models/TrackInfoMediaClass.dart";

abstract class TrackInfo {
  TrackInfo(Map<String, dynamic> jsonDecode, {required this.track}) {
    type = track["type"];
    title = track["title"];
  }

  static TrackInfo create(Map<String, dynamic> track) {
    final type = track["type"];
    switch (type) {
      case "text":
        return TypeMediaClass(track: track);
      case "image":
        return TypeMediaClass(track: track);
      case "audio":
        return TypeAudioClass(track: track);
      case "folder":
        return TypeFolderClass(track: track);
      case "other":
        return TypeMediaClass(track: track);
      default:
        throw UnsupportedError("Unsupported track type: $type");
    }
  }

  final Map<String, dynamic> track;
  late final String type;
  late final String title;
}
