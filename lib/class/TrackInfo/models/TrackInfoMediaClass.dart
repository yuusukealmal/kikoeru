// class
import 'package:kikoeru/class/TrackInfo/TrackInfo.dart';
import 'package:kikoeru/class/TrackInfo/models/TrackInfoWorkDetailClass.dart';

class TypeMediaClass extends TrackInfo {
  TypeMediaClass({required super.track}) : super(track) {
    hash = track["hash"] ?? "";
    trackInfoWorkDetail =
        TrackInfoWorkDetailClass(trackInfoWorkDetail: track["work"]);
    workTitle = track["workTitle"] ?? "";
    mediaStreamUrl = track["mediaStreamUrl"] ?? "";
    mediaDownloadUrl = track["mediaDownloadUrl"] ?? "";
    size = track["size"] ?? 0;
  }

  late final String hash;
  late final TrackInfoWorkDetailClass trackInfoWorkDetail;
  late final String workTitle;
  late final String mediaStreamUrl;
  late final String mediaDownloadUrl;
  late final int size;
}

class TypeAudioClass extends TrackInfo {
  TypeAudioClass({required super.track}) : super(track) {
    hash = track["hash"] ?? "";
    trackInfoWorkDetail =
        TrackInfoWorkDetailClass(trackInfoWorkDetail: track["work"]);
    workTitle = track["workTitle"] ?? "";
    mediaStreamUrl = track["mediaStreamUrl"] ?? "";
    mediaDownloadUrl = track["mediaDownloadUrl"] ?? "";
    streamLowQualityUrl = track["streamLowQualityUrl"] ?? "";
    duration = track["duration"].toDouble() ?? 0;
    size = track["size"] ?? 0;
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
  TypeFolderClass({required super.track}) : super(track) {
    children = (track["children"] as List<dynamic>? ?? []).map((childTrack) {
      return TrackInfo.create(childTrack);
    }).toList();
  }

  late final List<TrackInfo> children;
}
