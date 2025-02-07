import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/functions/getLeadintg.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/widget/WorkWidget/WorkWidget.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key, required this.work});

  final Work work;

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with WorkWidget {
  late Future<dynamic> _workInfoFuture;
  late AudioPlayer _audioPlayer;
  late ValueNotifier<bool> _isPlayingNotifier;
  late OverlayEntry _overlayEntry;
  String? currentAudioUrl;
  String? AudioTitle;
  String? WorkTitle;

  Future<dynamic> _getInfo() async {
    return await Request.getWorkInfo(widget.work.sourceID.split("RJ")[1]);
  }

  @override
  void initState() {
    super.initState();
    _workInfoFuture = _getInfo();
    _audioPlayer = AudioPlayer();
    _isPlayingNotifier = ValueNotifier<bool>(false);
    _overlayEntry = _createOverlayEntry();

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      _isPlayingNotifier.value = (state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    if (_overlayEntry.mounted) {
      _overlayEntry.remove();
    }
    _isPlayingNotifier.dispose();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          child: Container(
            padding: EdgeInsets.all(8.0),
            // color: Colors.white,
            child: Row(
              children: [
                Image.network(
                  widget.work.samCoverUrl,
                  height: 60,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: ListTile(
                  title: Text(AudioTitle ?? "正在播放",
                      style: TextStyle(fontSize: 16)),
                  subtitle:
                      Text(WorkTitle ?? "正在播放", style: TextStyle(fontSize: 12)),
                )),
                ValueListenableBuilder<bool>(
                  valueListenable: _isPlayingNotifier,
                  builder: (context, isPlaying, child) {
                    return IconButton(
                      icon: isPlaying
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        if (isPlaying) {
                          pauseAudio(_audioPlayer);
                        } else {
                          resumeAudio(_audioPlayer);
                        }
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _overlayEntry.remove();
                    stopAudio(_audioPlayer);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                WorkWidget.getRate(widget.work),
                const SizedBox(height: 8),
                WorkWidget.getSell(widget.work),
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
                      return GestureDetector(
                        child: ListTile(
                          leading: getLeading(workInfo[index]["type"]),
                          title: Text(workInfo[index]["title"]),
                        ),
                        onTap: () async {
                          if (workInfo[index]["type"] == "audio") {
                            await playAudio(workInfo[index]);
                            Overlay.of(context).insert(_overlayEntry);
                          }
                        },
                      );
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

  Future<void> playAudio(Map<String, dynamic> dict) async {
    String url = dict["mediaStreamUrl"];
    if (currentAudioUrl != url) {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      _isPlayingNotifier.value = true;
      setState(() {
        currentAudioUrl = url;
        AudioTitle = dict["title"];
        WorkTitle = dict["workTitle"];
      });
      if (_overlayEntry.mounted) {
        _overlayEntry.remove();
      }
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
    } else {
      _isPlayingNotifier.value == true
          ? pauseAudio(_audioPlayer)
          : resumeAudio(_audioPlayer);
    }
  }

  Future<void> pauseAudio(AudioPlayer player) async {
    await player.pause();
    _isPlayingNotifier.value = false;
  }

  Future<void> resumeAudio(AudioPlayer player) async {
    await player.resume();
    _isPlayingNotifier.value = true;
  }

  Future<void> stopAudio(AudioPlayer player) async {
    await player.stop();
    _isPlayingNotifier.value = false;
    _overlayEntry.remove();
  }
}
