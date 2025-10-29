// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:waterfall_flow/waterfall_flow.dart";

// class
import "package:kikoeru/class/WorkInfo/WorkInfo.dart";

// pages
import "package:kikoeru/pages/WorkDetail/pages/WorkDetailPage.dart";

Widget HomePageCardView(
  List<WorkInfo> works,
  ScrollController scrollController,
) {
  return Expanded(
    child: WaterfallFlow.builder(
      gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      controller: scrollController,
      itemCount: works.length,
      itemBuilder: (context, index) {
        final WorkInfo work = works[index];
        return GestureDetector(
          child: work.HomePageWorkCard(),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkPage(work: work)),
          ),
        );
      },
    ),
  );
}
