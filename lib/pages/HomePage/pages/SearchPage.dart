// flutter
import "package:flutter/material.dart";

// frb
import "package:kikoeru/src/rust/api/requests/config/types.dart";
import "package:kikoeru/src/rust/api/requests/interface.dart";

// pages
import "package:kikoeru/pages/HomePage/pages/BaseWorkPage.dart";

class SearchWorksPage extends BasePage {
  SearchWorksPage({super.key, required this.type, required this.query})
    : super(
        fetchWorks:
            (page, hasLanguage, order) => getSearchWorks(
              searchType: type,
              query: query,
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
