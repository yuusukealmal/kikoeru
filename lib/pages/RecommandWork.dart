import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/config/AudioProvider.dart';
import 'package:kikoeru/config/SharedPreferences.dart';
import 'package:kikoeru/pages/LoginPage.dart';
import 'package:kikoeru/pages/Work.dart';

class RecommandWorkPage extends StatefulWidget {
  const RecommandWorkPage({super.key});

  @override
  State<RecommandWorkPage> createState() => _RecommandWorkPageState();
}

class _RecommandWorkPageState extends State<RecommandWorkPage> {
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
    Future.delayed(Duration.zero, () {
      if (checkToken() != null) {
        _textController.text = currentPage.toString();
        fetchRecommandCurrentPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? checkToken() {
    String? token = SharedPreferencesHelper.getString('USER.TOKEN');
    return token;
  }

  Future<void> fetchRecommandCurrentPage() async {
    String resRecommend =
        await Request.getRecommandWorks(currentPage, hasLanguage ? 1 : 0);
    dynamic jsonData = jsonDecode(resRecommend);

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
      fetchRecommandCurrentPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPreferencesHelper.getString("USER.RECOMMENDER.UUID") != null) {
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
                      fetchRecommandCurrentPage();
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
                    MaterialPageRoute(
                        builder: (context) => WorkPage(work: work)),
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
                  onPressed: currentPage > 1
                      ? () => changePage(currentPage - 1)
                      : null,
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
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("請先登入"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                setState(() {
                  if (checkToken() != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("成功登入")),
                    );
                    fetchRecommandCurrentPage();
                  }
                });
              },
              child: Text("登入"),
            ),
          ],
        ),
      );
    }
  }
}
