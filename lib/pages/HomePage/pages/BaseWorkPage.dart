// flutter
import "dart:convert";
import "package:flutter/material.dart";

// widgets
import "package:kikoeru/pages/HomePage/widgets/HomePageHeader.dart";
import "package:kikoeru/pages/HomePage/widgets/HomePageCardView.dart";
import "package:kikoeru/pages/HomePage/widgets/HomePageFooter.dart";

// function
import "package:kikoeru/pages/HomePage/logic/HomePageScroll.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";
import "package:kikoeru/class/SearchResult/SearchResult.dart";

abstract class BasePage extends StatefulWidget {
  final Future<String> Function(int page, bool hasLanguage, int order)
  fetchWorks;

  const BasePage({super.key, required this.fetchWorks});

  @override
  State<BasePage> createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  bool _isLoading = false;
  int sortIndex = 1;
  bool hasLanguage = false;
  List<WorkInfo> works = [];
  int totalItems = 0;
  int currentPage = 1;
  final int itemsPerPage = 20;
  late int totalPages;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (checkLogin()) {
      _textController.text = currentPage.toString();
      fetchCurrentPage();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool checkLogin() {
    return true;
  }

  Future<void> fetchCurrentPage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String response = await widget.fetchWorks(
        currentPage,
        hasLanguage,
        sortIndex,
      );
      Searchresult searchresult = Searchresult.fromMap(jsonDecode(response));

      if (!mounted) return;

      setState(() {
        totalItems = searchresult.pagination.totalCount;
        totalPages = (totalItems / itemsPerPage).ceil();
        works = searchresult.workInfoList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("發生錯誤：$e")));
    }
  }

  void changePage(int page) {
    if (page < 1 || (totalPages > 0 && page > totalPages)) return;
    setState(() {
      currentPage = page;
      _textController.text = currentPage.toString();
      fetchCurrentPage();
    });

    resetScroll(_scrollController);
  }

  void onOrderChange(int index) {
    setState(() {
      sortIndex = index;
      changePage(1);
    });
  }

  void onHasLanguageChange(bool value) {
    setState(() {
      currentPage = 1;
      _textController.text = currentPage.toString();
      hasLanguage = value;
      fetchCurrentPage();
    });

    resetScroll(_scrollController);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        HomePageHeader(
          context,
          widget.runtimeType,
          totalItems,
          sortIndex,
          hasLanguage,
          onOrderChange,
          onHasLanguageChange,
        ),
        if (works.isEmpty)
          Expanded(child: Center(child: Text("沒有資料可以顯示")))
        else ...[
          HomePageCardView(works, _scrollController),
          HomePageFooter(
            context,
            currentPage,
            totalPages,
            _textController,
            changePage,
          ),
        ],
      ],
    );
  }
}
