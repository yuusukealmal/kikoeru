import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/config/AudioProvider.dart';
import 'package:kikoeru/functions/getLeadintg.dart';
import 'package:kikoeru/widget/WorkWidget/WorkWidget.dart';
import 'package:kikoeru/widget/WorkWidget/openContent.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key, required this.work});

  final Work work;

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with WorkWidget, openWorkContent {
  late Future<dynamic> _workInfoFuture;

  Future<dynamic> _getInfo() async {
    return await Request.getWorkInfo(id: widget.work.sourceID.split("RJ")[1]);
  }

  @override
  void initState() {
    super.initState();
    _workInfoFuture = _getInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _workInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error Occurs"));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text("No Data Available"));
        }
        final dynamic workInfo = jsonDecode(snapshot.data);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("作品"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    WorkWidget.getWorkImage(widget.work),
                    WorkWidget.getWorkRJID(widget.work, 12, 14),
                    WorkWidget.getWorkReleaseDate(widget.work),
                  ],
                ),
                WorkWidget.getTitleandCircle(widget.work),
                WorkWidget.getRate(widget.work, true),
                const SizedBox(height: 8),
                WorkWidget.getSell(widget.work, true),
                const SizedBox(height: 8),
                WorkWidget.getTag(widget.work),
                const SizedBox(height: 8),
                WorkWidget.getVas(widget.work),
                const SizedBox(height: 8),
                if (workInfo.toString().contains("error"))
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        workInfo.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    itemCount: workInfo.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return _buildItem(workInfo[index]);
                    },
                  ),
                SizedBox(height: 75)
              ],
            ),
          ),
        );
      },
    );
  }

  void playAudio(BuildContext context, Map<String, dynamic> dict) async {
    Provider.of<AudioProvider>(context, listen: false)
        .playAudio(context, dict, widget.work.samCoverUrl);
  }

  void stopAudio(BuildContext context) async {
    Provider.of<AudioProvider>(context, listen: false).stopAudio();
  }

  void pauseAudio(BuildContext context) async {
    Provider.of<AudioProvider>(context, listen: false).pauseAudio();
  }

  void resumeAudio(BuildContext context) async {
    Provider.of<AudioProvider>(context, listen: false).resumeAudio();
  }

  Widget _buildItem(Map<String, dynamic> item) {
    if (item["type"] == "folder") {
      return ExpansionTile(
        leading: getLeading(item["type"]),
        title: Text(item["title"]),
        children: item["children"].map<Widget>((child) {
          return _buildItem(child);
        }).toList(),
      );
    } else {
      return ListTile(
        leading: getLeading(item["type"]),
        title: Text(item["title"]),
        onTap: () {
          switch (item["type"]) {
            case "audio":
              if (item["title"].endsWith(".mp3") ||
                  item["title"].endsWith(".m4a") ||
                  item["title"].endsWith(".wav")) {
                playAudio(context, item);
              }
              break;
            case "text":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      openText(item["title"], item["mediaDownloadUrl"]),
                ),
              );
              break;
            case "image":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      openImage(context, item["title"], item["mediaStreamUrl"]),
                ),
              );
            case "other":
              if (item["title"].endsWith(".pdf")) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        openPdf(item["title"], item["mediaStreamUrl"]),
                  ),
                );
              }
              break;
          }
        },
      );
    }
  }
}
