import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kikoeru/api/Request.dart';
import 'package:kikoeru/class/asmr.dart';

class AllWorksPage extends StatefulWidget {
  const AllWorksPage({super.key});

  @override
  State<AllWorksPage> createState() => _AllWorksPageState();
}

class _AllWorksPageState extends State<AllWorksPage> {
  List<dynamic> works = [];
  int totalItems = 0;
  int currentPage = 1;
  final int itemsPerPage = 20;
  late int totalPages;

  @override
  void initState() {
    super.initState();
    fetchAlLCurrentPage();
  }

  Future<void> fetchAlLCurrentPage() async {
    String resAll = await Request.getALlWorks(currentPage);
    dynamic jsonData = jsonDecode(resAll);

    setState(() {
      totalItems = jsonData["pagination"]["totalCount"];
      totalPages = (totalItems / itemsPerPage).ceil();
      works = jsonData["works"];
      debugPrint(works.length.toString());
    });
  }

  void changePage(int page) async {
    if (page < 1 || page > totalPages) return;
    setState(() {
      currentPage = page;
      fetchAlLCurrentPage();
    });
  }

  List<int> getPageNumbers() {
    List<int> pages = [];
    if (totalPages <= 7) {
      pages = List.generate(totalPages, (index) => index + 1);
    } else {
      if (currentPage <= 4) {
        pages = [1, 2, 3, 4, 5, -1, totalPages];
      } else if (currentPage >= totalPages - 3) {
        pages = [
          1,
          -1,
          totalPages - 4,
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    if (works.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                "全部作品 ($totalItems)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: works.length,
            itemBuilder: (context, index) {
              final work = works[index];
              return WorkCard(
                id: work["id"],
                imageUrl: work["mainCoverUrl"],
                title: work["title"],
                cvs: (work["vas"] != null && work["vas"].isNotEmpty)
                    ? (work["vas"] as List)
                        .map((va) => va["name"].toString())
                        .toList()
                    : [],
                date: work["release"],
                circle: work["name"],
                tags: work["tags"]
                    .map((tag) => tag["i18n"]["zh-cn"]["name"]
                        .replaceAll(" ", "")) //.split("/")?[0]
                    .toList(),
                duration: work["duration"],
                price: work["price"],
                selled: work["dl_count"],
                rating: work["rate_average_2dp"].toDouble(),
                rateCount: work["rate_count"],
                reviewCount: work["review_count"],
                url: work["source_url"],
                ageCategory: work["age_category_string"] ?? "",
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed:
                    currentPage > 1 ? () => changePage(currentPage - 1) : null,
              ),
              ...getPageNumbers().map(
                (page) {
                  if (page == -1) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text("..."),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentPage == page
                              ? Colors.blue
                              : Colors.grey[800],
                        ),
                        onPressed: () => changePage(page),
                        child: Text(
                          "$page",
                          style: TextStyle(
                              color: currentPage == page
                                  ? Colors.white
                                  : Colors.grey[300]),
                        ),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: currentPage < totalPages
                    ? () => changePage(currentPage + 1)
                    : null,
              ),
              const SizedBox(width: 8),
              Text("Go to"),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    int? page = int.tryParse(value);
                    FocusScope.of(context).unfocus();
                    if (page != null && page >= 1 && page <= totalPages) {
                      changePage(page);
                    }
                    _textController.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
