class VasClass {
  VasClass.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? "";
    name = map["name"] ?? "";
  }

  late final String id;
  late final String name;
}
