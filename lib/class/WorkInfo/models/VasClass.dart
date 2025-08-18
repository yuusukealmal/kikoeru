class VasClass {
  VasClass({required this.vasDetail}) {
    id = vasDetail["id"] ?? "";
    name = vasDetail["name"] ?? "";
  }

  final Map<String, dynamic> vasDetail;
  late final String id;
  late final String name;
}
