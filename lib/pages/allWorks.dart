import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/config/AudioProvider.dart';
import 'package:kikoeru/pages/Work.dart';

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
  final TextEditingController _textController = TextEditingController();

  String order = "最新收錄";
  final List<String> orders = [
    "發售日期倒序",
    "最新收錄",
    "我的評價倒序",
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
    _textController.text = currentPage.toString();
    fetchAlLCurrentPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchAlLCurrentPage() async {
    String resAll =
        await Request.getALlWorks(currentPage, orders.indexOf(order));
    dynamic jsonData = jsonDecode(resAll);

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
      fetchAlLCurrentPage();
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
              SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: DropdownButton<String>(
                  isDense: true,
                  value: order,
                  onChanged: (String? value) {
                    setState(() {
                      order = value!;
                      changePage(1);
                    });
                  },
                  items: orders.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: value == order
                                  ? const Color.fromARGB(255, 46, 129, 211)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                            ),
                      ),
                    );
                  }).toList(),
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
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
