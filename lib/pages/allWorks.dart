import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/widget/BaseWorkPage.dart';

class AllWorksPage extends BaseWorkPage {
  AllWorksPage({super.key})
      : super(
          fetchWorks: (page, hasLanguage, order) =>
              Request.getAllWorks(index: page, subtitle: hasLanguage ? 1 : 0, order: order),
        );

  @override
  State<AllWorksPage> createState() => _AllWorksPageState();
}

class _AllWorksPageState extends BaseWorkPageState<AllWorksPage> {}
