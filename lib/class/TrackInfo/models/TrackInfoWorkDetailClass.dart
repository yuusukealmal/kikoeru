class TrackInfoWorkDetailClass {
  TrackInfoWorkDetailClass.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    sourceID = map["source_id"];
    sourceType = map["source_type"];
  }

  late final int id;
  late final String sourceID;
  late final String sourceType;
}
