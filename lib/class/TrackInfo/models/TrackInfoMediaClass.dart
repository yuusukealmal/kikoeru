// class
import "package:kikoeru/class/TrackInfo/TrackInfo.dart";
import "package:kikoeru/class/TrackInfo/models/TrackInfoWorkDetailClass.dart";

class TypeMediaClass extends TrackInfo {
  TypeMediaClass.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    hash = map["hash"] ?? "";
    trackInfoWorkDetail = TrackInfoWorkDetailClass.fromMap(map["work"]);
    workTitle = map["workTitle"] ?? "";
    mediaStreamUrl = map["mediaStreamUrl"] ?? "";
    mediaDownloadUrl = map["mediaDownloadUrl"] ?? "";
    size = map["size"] ?? 0;
  }

  late final String hash;
  late final TrackInfoWorkDetailClass trackInfoWorkDetail;
  late final String workTitle;
  late final String mediaStreamUrl;
  late final String mediaDownloadUrl;
  late final int size;
}

class TypeAudioClass extends TrackInfo {
  TypeAudioClass.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    hash = map["hash"] ?? "";
    trackInfoWorkDetail = TrackInfoWorkDetailClass.fromMap(map["work"]);
    workTitle = map["workTitle"] ?? "";
    mediaStreamUrl = map["mediaStreamUrl"] ?? "";
    mediaDownloadUrl = map["mediaDownloadUrl"] ?? "";
    streamLowQualityUrl = map["streamLowQualityUrl"] ?? "";
    duration = map["duration"].toDouble() ?? 0;
    size = map["size"] ?? 0;
  }

  late final String hash;
  late final TrackInfoWorkDetailClass trackInfoWorkDetail;
  late final String workTitle;
  late final String mediaStreamUrl;
  late final String mediaDownloadUrl;
  late final String streamLowQualityUrl;
  late final double duration;
  late final int size;
}

class TypeFolderClass extends TrackInfo {
  TypeFolderClass.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    children =
        (map["children"] as List<dynamic>? ?? []).map((childTrack) {
          return TrackInfo.create(childTrack);
        }).toList();
  }

  late final List<TrackInfo> children;
}
