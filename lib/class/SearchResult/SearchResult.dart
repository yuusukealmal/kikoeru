// class
import "package:kikoeru/class/SearchResult/models/PaginationClass.dart";
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

class Searchresult {
  Searchresult.fromMap(Map<String, dynamic> map) {
    workInfoList =
        (map["works"] as List).map((e) => WorkInfo.fromMap(e)).toList();
    pagination = PaginationClass.fromMap(map["pagination"]);
  }

  late final List<WorkInfo> workInfoList;
  late final PaginationClass pagination;
}
