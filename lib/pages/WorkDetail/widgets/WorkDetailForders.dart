// flutter
import 'package:flutter/material.dart';

Widget WorkDetailFolders(
  dynamic workTrack,
  Widget Function(Map<String, dynamic>, {List<dynamic>? parentFolder})
      buildItem,
) {
  if (workTrack.toString().contains("error")) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          workTrack.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  } else {
    return ListView.separated(
      itemCount: workTrack.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => buildItem(workTrack[index]),
    );
  }
}
