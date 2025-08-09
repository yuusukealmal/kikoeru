import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/pages/HomePage/BaseWorkPage.dart';

class SearchWorksPage extends BasePage {
  SearchWorksPage({super.key, required this.type, required this.query})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getSearchWorks(
            type: type,
            querys: query,
            index: page,
            subtitle: hasLanguage ? 1 : 0,
            order: order,
          ),
        );

  final SearchType type;
  final String query;

  @override
  State<SearchWorksPage> createState() => _SearchWorksPageState();
}

class _SearchWorksPageState extends BasePageState<SearchWorksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.query),
      ),
      body: super.build(context),
    );
  }
}
