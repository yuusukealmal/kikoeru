// class
import "package:kikoeru/class/TrackInfo/models/TrackInfoMediaClass.dart";

abstract class TrackInfo {
  TrackInfo.fromMap(Map<String, dynamic> map) {
    type = map["type"];
    title = map["title"];
  }

  static TrackInfo create(Map<String, dynamic> map) {
    final type = map["type"];
    switch (type) {
      case "text":
      case "image":
      case "other":
        return TypeMediaClass.fromMap(map);
      case "audio":
        return TypeAudioClass.fromMap(map);
      case "folder":
        return TypeFolderClass.fromMap(map);
      default:
        throw UnsupportedError("Unsupported track type: $type");
    }
  }

  late final String type;
  late final String title;
}
