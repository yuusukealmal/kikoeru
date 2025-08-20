class TrackInfoWorkDetailClass {
  TrackInfoWorkDetailClass({required this.trackInfoWorkDetail}) {
    id = trackInfoWorkDetail["id"];
    sourceID = trackInfoWorkDetail["source_id"];
    sourceType = trackInfoWorkDetail["source_type"];
  }

  final Map<String, dynamic> trackInfoWorkDetail;
  late final int id;
  late final String sourceID;
  late final String sourceType;
}
