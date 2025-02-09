import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/functions/PageBehavior.dart';
import 'package:kikoeru/pages/Work.dart';

class PopularWorkPage extends StatefulWidget {
  const PopularWorkPage({super.key});

  @override
  State<PopularWorkPage> createState() => _PopularWorkPageState();
}

class _PopularWorkPageState extends State<PopularWorkPage> with PageBehavior {
  List<dynamic> works = [];
  int totalItems = 0;
  int currentPage = 1;
  final int itemsPerPage = 20;
  late int totalPages;

  @override
  void initState() {
    super.initState();
    fetchPopularCurrentPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchPopularCurrentPage() async {
    String resPopular = await Request.getPopularWorks(currentPage);
    dynamic jsonData = jsonDecode(resPopular);

    setState(() {
      totalItems = jsonData["pagination"]["totalCount"];
      totalPages = (totalItems / itemsPerPage).ceil();
      works = jsonData["works"];
    });
  }

  void changePage(int page) async {
    if (page < 1 || page > totalPages) return;
    setState(() {
      currentPage = page;
      fetchPopularCurrentPage();
    });
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
              Expanded(
                child: Text(
                  "全部作品 ($totalItems)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
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
              childAspectRatio: 0.7,
            ),
            itemCount: works.length,
            itemBuilder: (context, index) {
              final Work work = Work(work: works[index]);
              return GestureDetector(
                child: work.AllWorkCard(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkPage(work: work)),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 4,
            runSpacing: 4,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed:
                    currentPage > 1 ? () => changePage(currentPage - 1) : null,
              ),
              ...getPageNumbers(currentPage, totalPages).map(
                (page) {
                  if (page == -1) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text("..."),
                    );
                  } else {
                    return ElevatedButton(
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
                              : Colors.grey[300],
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
        SizedBox(height: 75)
      ],
    );
  }
}
