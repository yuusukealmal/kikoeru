import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/config/AudioProvider.dart';
import 'package:kikoeru/functions/getLeadintg.dart';
import 'package:kikoeru/widget/WorkWidget/openContent.dart';

// card detail
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/WorkImage.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/WorkRjID.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/ReleaseDate.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/TitleCircle.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Rate.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Sell.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Tag.dart';
import 'package:kikoeru/widget/WorkWidget/RJCardWidgets/Va.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key, required this.work});

  final Work work;

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with openWorkContent {
  late Future<dynamic> _workInfoFuture;

  @override
  void initState() {
    super.initState();
    _workInfoFuture =
        Request.getWorkInfo(id: widget.work.sourceID.split("RJ")[1]);
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
                    getWorkImage(widget.work),
                    getWorkRJID(widget.work, top: 12, left: 14),
                    getWorkReleaseDate(widget.work),
                  ],
                ),
                getTitleandCircle(context, widget.work),
                getRate(widget.work, isDetail: true),
                const SizedBox(height: 8),
                getSell(widget.work, isDetail: true),
                const SizedBox(height: 8),
                getTag(context, widget.work),
                const SizedBox(height: 8),
                getVas(context, widget.work),
                const SizedBox(height: 8),
                if (workInfo.toString().contains("error"))
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        workInfo.toString(),
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    itemCount: workInfo.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) =>
                        _buildItem(workInfo[index]),
                  ),
                const SizedBox(height: 75),
              ],
            ),
          ),
        );
      },
    );
  }

  void playAudio(
      BuildContext context, List<Map<String, dynamic>> dict, int index) {
    Provider.of<AudioProvider>(context, listen: false).playAudioList(
      context,
      index,
      dict,
      widget.work.mainCoverUrl,
      widget.work.samCoverUrl,
    );
  }

  void stopAudio(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).stopAudio();
  }

  void toggleAudio(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).togglePlayPause();
  }

  List<Map<String, dynamic>> _getAudioList(List<dynamic>? children) {
    return children
            ?.where((child) => child["type"] == "audio")
            .map((child) => child as Map<String, dynamic>)
            .toList() ??
        [];
  }

  Widget _buildItem(Map<String, dynamic> item, {List<dynamic>? parentFolder}) {
    if (item["type"] == "folder") {
      return ExpansionTile(
        leading: getLeading(item["type"]),
        title: Text(item["title"]),
        children: item["children"]
            .map<Widget>(
              (child) => _buildItem(
                child,
                parentFolder: item["children"],
              ),
            )
            .toList(),
      );
    } else if (item["type"] == "audio") {
      return ListTile(
        leading: getLeading(item["type"]),
        title: Text(item["title"]),
        onTap: () {
          List<Map<String, dynamic>> audioList = _getAudioList(parentFolder);
          playAudio(context, audioList, audioList.indexOf(item));
        },
      );
    } else {
      return ListTile(
        leading: getLeading(item["type"]),
        title: Text(item["title"]),
        onTap: () => _handleItemTap(context, item),
      );
    }
  }

  void _handleItemTap(BuildContext context, Map<String, dynamic> item) {
    switch (item["type"]) {
      case "text":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => openText(
              item["title"],
              item["mediaDownloadUrl"],
            ),
          ),
        );
        break;
      case "image":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => openImage(
              context,
              item["title"],
              item["mediaStreamUrl"],
            ),
          ),
        );
        break;
      case "other":
        if (item["title"].endsWith(".pdf")) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => openPdf(
                item["title"],
                item["mediaStreamUrl"],
              ),
            ),
          );
        }
        break;
    }
  }
}
