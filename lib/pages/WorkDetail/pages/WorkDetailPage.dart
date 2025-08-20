// flutter
import "dart:convert";
import "package:flutter/material.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";
import "package:kikoeru/class/TrackInfo/TrackInfo.dart";
import "package:kikoeru/class/TrackInfo/models/TrackInfoMediaClass.dart";

// api
import "package:kikoeru/api/WorkRequest/httpRequests.dart";

// function
import "package:kikoeru/pages/WorkDetail/logic/ItemTapHandle.dart";

// widget
import "package:kikoeru/pages/WorkDetail/widgets/WorkDetailForders.dart";
import "package:kikoeru/pages/WorkDetail/widgets/WorkDetailsLeading.dart";

// mixin
import "package:kikoeru/pages/WorkDetail/logic/Audio.dart";

class WorkPage extends StatefulWidget {
  const WorkPage({super.key, required this.work});

  final WorkInfo work;

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with WorkAudio, ItemTap {
  late Future<String> _workTrackFuture;

  Widget _buildWorkDetailItems(dynamic item,
      {List<dynamic>? parentFolder, String? parentTitle}) {
    if (item is TypeFolderClass) {
      return ExpansionTile(
        leading: Leading(item.type),
        title: Text(item.title),
        children: item.children
            .map<Widget>(
              (child) => _buildWorkDetailItems(
                child,
                parentFolder: item.children,
                parentTitle: item.title,
              ),
            )
            .toList(),
      );
    } else if (item is TypeAudioClass) {
      return ListTile(
        leading: Leading(item.type),
        title: Text(item.title),
        onTap: () {
          (List<TypeAudioClass>, List<TypeMediaClass>) audioList =
              getAudioList(parentFolder);
          playAudio(
            context,
            parentTitle!,
            audioList.$1,
            audioList.$1.indexOf(item),
            widget.work.mainCoverUrl,
            widget.work.samCoverUrl,
            audioList.$2,
          );
        },
      );
    } else {
      return ListTile(
        leading: Leading(item.type),
        title: Text(item.title),
        onTap: () => handleItemTap(context, item),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _workTrackFuture = Request.getWorkTrack(id: widget.work.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _workTrackFuture,
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
        final List<TrackInfo> workTrack = (jsonDecode(snapshot.data!) as List)
            .map((e) => TrackInfo.create(e as Map<String, dynamic>))
            .toList();

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
                WorkDetailFolders(workTrack, _buildWorkDetailItems),
                const SizedBox(height: 75),
              ],
            ),
          ),
        );
      },
    );
  }
}
