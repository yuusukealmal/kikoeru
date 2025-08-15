// flutter
import 'dart:convert';
import 'package:flutter/material.dart';

// widgets
import 'package:kikoeru/pages/HomePage/widgets/HomePageHeader.dart';
import 'package:kikoeru/pages/HomePage/widgets/HomePageCardView.dart';
import 'package:kikoeru/pages/HomePage/widgets/HomePageFooter.dart';

// function
import 'package:kikoeru/pages/HomePage/logic/HomePageScroll.dart';

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
  List<dynamic> works = [];
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
    String response = await widget.fetchWorks(
        currentPage, hasLanguage, orders.indexOf(order));
    dynamic jsonData = jsonDecode(response);

    if (!mounted) return;

    setState(() {
      totalItems = jsonData["pagination"]["totalCount"];
      totalPages = (totalItems / itemsPerPage).ceil();
      works = jsonData["works"];
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
    if (works.isEmpty) {
      return const Center(child: CircularProgressIndicator());
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
