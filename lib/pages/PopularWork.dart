import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/widget/BaseWorkPage.dart';

class PopularWorkPage extends BaseWorkPage {
  PopularWorkPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) => Request.getPopularWorks(
              index: page, subtitle: hasLanguage ? 1 : 0),
        );

  @override
  State<PopularWorkPage> createState() => _PopularWorkPageState();
}

class _PopularWorkPageState extends BaseWorkPageState<PopularWorkPage> {}
