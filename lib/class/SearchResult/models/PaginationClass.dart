class PaginationClass {
  PaginationClass.fromMap(Map<String, dynamic> map) {
    currentPage = map["currentPage"] ?? 0;
    pageSize = map["pageSize"] ?? 0;
    totalCount = map["totalCount"] ?? 0;
  }

  late final int currentPage;
  late final int pageSize;
  late final int totalCount;
}
