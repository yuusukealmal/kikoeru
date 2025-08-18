// class
import 'package:kikoeru/class/SearchResult/model/PaginationClass.dart';
import 'package:kikoeru/class/WorkInfo/WorkInfo.dart';

class Searchresult {
  Searchresult({required this.searchResultDetail}) {
    workInfoList = (searchResultDetail['works'] as List)
        .map((e) => WorkInfo(work: e))
        .toList();
    pagination =
        PaginationClass(PaginationDetail: searchResultDetail['pagination']);
  }

  final Map<String, dynamic> searchResultDetail;
  late final List<WorkInfo> workInfoList;
  late final PaginationClass pagination;
}
