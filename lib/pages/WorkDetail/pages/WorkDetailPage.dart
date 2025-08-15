// flutter
import 'dart:convert';
import 'package:flutter/material.dart';

// class
import 'package:kikoeru/class/models/Work.dart';

// api
import 'package:kikoeru/api/WorkRequest/httpRequests.dart';

// function
import 'package:kikoeru/pages/WorkDetail/logic/ItemTapHandle.dart';

// widget
import 'package:kikoeru/pages/WorkDetail/widgets/WorkDetailForders.dart';
import 'package:kikoeru/pages/WorkDetail/widgets/WorkDetailsLeading.dart';

// mixin
import 'package:kikoeru/pages/WorkDetail/logic/Audio.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key, required this.work});

  final Work work;

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with WorkAudio, ItemTap {
  late Future<dynamic> _workInfoFuture;

  Widget _buildWorkDetailItems(Map<String, dynamic> item,
      {List<dynamic>? parentFolder, String? parentTitle}) {
    if (item["type"] == "folder") {
      return ExpansionTile(
        leading: Leading(item["type"]),
        title: Text(item["title"]),
        children: item["children"]
            .map<Widget>(
              (child) => _buildWorkDetailItems(
                child,
                parentFolder: item["children"],
                parentTitle: item["title"],
              ),
            )
            .toList(),
      );
    } else if (item["type"] == "audio") {
      return ListTile(
        leading: Leading(item["type"]),
        title: Text(item["title"]),
        onTap: () {
          List<Map<String, dynamic>> audioList = getAudioList(parentFolder);
          playAudio(
            context,
            parentTitle!,
            audioList,
            audioList.indexOf(item),
            widget.work.mainCoverUrl,
            widget.work.samCoverUrl,
          );
        },
      );
    } else {
      return ListTile(
        leading: Leading(item["type"]),
        title: Text(item["title"]),
        onTap: () => handleItemTap(context, item),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _workInfoFuture = Request.getWorkInfo(id: widget.work.id.toString());
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
                widget.work.DetailWorkCard(),
                WorkDetailFolders(workInfo, _buildWorkDetailItems),
                const SizedBox(height: 75),
              ],
            ),
          ),
        );
      },
    );
  }
}
