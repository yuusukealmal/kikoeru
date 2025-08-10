// flutter
import 'package:flutter/material.dart';

Widget WorkDetailFolders(
  dynamic workInfo,
  Widget Function(Map<String, dynamic>, {List<dynamic>? parentFolder})
      buildItem,
) {
  if (workInfo.toString().contains("error")) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          workInfo.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  } else {
    return ListView.separated(
      itemCount: workInfo.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => buildItem(workInfo[index]),
    );
  }
}
