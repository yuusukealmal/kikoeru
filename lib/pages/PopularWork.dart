import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/config/AudioProvider.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/pages/Work.dart';

class PopularWorkPage extends StatefulWidget {
  const PopularWorkPage({super.key});

  @override
  State<PopularWorkPage> createState() => _PopularWorkPageState();
}

class _PopularWorkPageState extends State<PopularWorkPage> {
  List<dynamic> works = [];
  int totalItems = 0;
  int currentPage = 1;
  bool hasLanguage = false;
  final int itemsPerPage = 20;
  late int totalPages;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = currentPage.toString();
    fetchPopularCurrentPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchPopularCurrentPage() async {
    String resPopular =
        await Request.getPopularWorks(currentPage, hasLanguage ? 1 : 0);
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
      _textController.text = currentPage.toString();
      fetchPopularCurrentPage();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Checkbox(
                value: hasLanguage,
                onChanged: (value) {
                  setState(() {
                    currentPage = 1;
                    _textController.text = currentPage.toString();
                    hasLanguage = value!;
                    fetchPopularCurrentPage();
                  });
                },
              ),
              Text("帶字幕", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
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
              SizedBox(
                width: 40,
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.2),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  onSubmitted: (value) {
                    int? page = int.tryParse(value);
                    FocusScope.of(context).unfocus();
                    if (page != null && page >= 1 && page <= totalPages) {
                      changePage(page);
                    } else {
                      _textController.text = currentPage.toString();
                    }
                  },
                ),
              ),
              Text(" / $totalPages", style: TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: currentPage < totalPages
                    ? () => changePage(currentPage + 1)
                    : null,
              ),
            ],
          ),
        ),
        if (Provider.of<AudioProvider>(context).isOverlayShow)
          SizedBox(height: 90)
      ],
    );
  }
}
