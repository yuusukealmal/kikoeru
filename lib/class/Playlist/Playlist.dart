class Playlist {
  Playlist({required this.playlistDetail}) {
    id = playlistDetail["id"];
    userName = playlistDetail["user_name"];
    privacy = playlistDetail["privacy"];
    locale = playlistDetail["locale"];
    playBackCount = playlistDetail["playback_count"];
    name = playlistDetail["name"];
    description = playlistDetail["description"];
    createAt = playlistDetail["created_at"];
    updatedAt = playlistDetail["updated_at"];
  }

  final Map<String, dynamic> playlistDetail;
  late final String id;
  late final String userName;
  late final int privacy;
  late final String locale;
  late final int playBackCount;
  late final String name;
  late final String description;
  late final String createAt;
  late final String updatedAt;
}
