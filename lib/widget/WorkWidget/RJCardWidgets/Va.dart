import 'package:flutter/material.dart';
import 'package:kikoeru/api/RequestPage.dart';
import 'package:kikoeru/class/workInfo.dart';
import 'package:kikoeru/pages/HomePage/SearchPage.dart';

Widget getVas(BuildContext context, Work work) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 8),
    child: Wrap(
      spacing: 6,
      runSpacing: 4,
      children: work.Vas.map((va) => va["name"].toString())
          .toList()
          .map(
            (cv) => GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 150, 136),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  cv,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchWorksPage(
                      type: SearchType.VAS,
                      query: cv,
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    ),
  );
}
