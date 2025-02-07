mixin PageBehavior {
  List<int> getPageNumbers(int currentPage, int totalPages) {
    List<int> pages = [];
    if (totalPages <= 7) {
      pages = List.generate(totalPages, (index) => index + 1);
    } else {
      if (currentPage <= 4) {
        pages = [1, 2, 3, 4, -1, totalPages];
      } else if (currentPage >= totalPages - 3) {
        pages = [
          1,
          -1,
          totalPages - 3,
          totalPages - 2,
          totalPages - 1,
          totalPages
        ];
      } else {
        pages = [
          1,
          -1,
          currentPage - 1,
          currentPage,
          currentPage + 1,
          -1,
          totalPages
        ];
      }
    }
    return pages;
  }
}
