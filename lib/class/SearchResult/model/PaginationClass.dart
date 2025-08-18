class PaginationClass {
  PaginationClass({required this.PaginationDetail}) {
    currentPage = PaginationDetail['currentPage'] ?? 0;
    pageSize = PaginationDetail['pageSize'] ?? 0;
    totalCount = PaginationDetail['totalCount'] ?? 0;
  }

  final Map<String, dynamic> PaginationDetail;
  late final int currentPage;
  late final int pageSize;
  late final int totalCount;
}
