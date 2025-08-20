// flutter
import 'dart:convert';
import 'package:flutter/material.dart';

// widgets
import 'package:kikoeru/pages/HomePage/widgets/HomePageHeader.dart';
import 'package:kikoeru/pages/HomePage/widgets/HomePageCardView.dart';
import 'package:kikoeru/pages/HomePage/widgets/HomePageFooter.dart';

// function
import 'package:kikoeru/pages/HomePage/logic/HomePageScroll.dart';

// class
import 'package:kikoeru/class/WorkInfo/WorkInfo.dart';
import 'package:kikoeru/class/SearchResult/SearchResult.dart';

abstract class BasePage extends StatefulWidget {
  final Future<String> Function(
    int page,
    bool hasLanguage,
    int order,
  ) fetchWorks;

  const BasePage({super.key, required this.fetchWorks});

  @override
  State<BasePage> createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  bool _isLoading = false;
  List<WorkInfo> works = [];
  int totalItems = 0;
  int currentPage = 1;
  bool hasLanguage = false;
  final int itemsPerPage = 20;
  late int totalPages;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String order = "最新收錄";
  final List<String> orders = [
    "發售日期倒序",
    "最新收錄",
    // "我的評價倒序",
    "銷量倒序",
    "價格倒序",
    "評價倒序",
    "評論數量倒序",
    "RJ號倒敘",
    "全年齡倒序",
    "隨機"
  ];

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

    String response = await widget.fetchWorks(
        currentPage, hasLanguage, orders.indexOf(order));
    Searchresult searchresult =
        Searchresult(searchResultDetail: jsonDecode(response));

    if (!mounted) return;

    setState(() {
      totalItems = searchresult.pagination.totalCount;
      totalPages = (totalItems / itemsPerPage).ceil();
      works = searchresult.workInfoList;
      _isLoading = false;
    });
  }

  void changePage(int page) {
    if (page < 1 || page > totalPages) return;
    setState(() {
      currentPage = page;
      _textController.text = currentPage.toString();
      fetchCurrentPage();
    });

    resetScroll(_scrollController);
  }

  void onOrderChange(String order) {
    setState(() {
      order = order;
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
    if (works.isEmpty) {
      return const Center(child: Text("沒有資料可以顯示"));
    }

    return Column(
      children: [
        HomePageHeader(
          context,
          runtimeType,
          totalItems,
          order,
          orders,
          hasLanguage,
          onOrderChange,
          onHasLanguageChange,
        ),
        HomePageCardView(works, _scrollController),
        HomePageFooter(
          context,
          currentPage,
          totalPages,
          _textController,
          changePage,
        ),
      ],
    );
  }
}
