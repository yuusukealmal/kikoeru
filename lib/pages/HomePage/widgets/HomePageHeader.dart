// flutter
import 'package:flutter/material.dart';

// runTimeType pages
import 'package:kikoeru/pages/HomePage/pages/DefaultPages.dart';
import 'package:kikoeru/pages/HomePage/pages/SearchPage.dart';

Widget HomePageHeader(
  BuildContext context,
  Type runtimeType,
  int totalItems,
  String order,
  List<String> orders,
  bool hasLanguage,
  void Function(String) onOrderChange,
  void Function(bool) onHasLanguageChange,
) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "全部作品 ($totalItems)",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 12),
        if (runtimeType == AllWorksPage || runtimeType == SearchWorksPage)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(80),
            ),
            child: DropdownButton<String>(
              isDense: true,
              value: order,
              onChanged: (String? value) {
                onOrderChange(value!);
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
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                  ),
                );
              }).toList(),
              underline: Container(),
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        Checkbox(
          value: hasLanguage,
          onChanged: (value) {
            onHasLanguageChange(value!);
          },
        ),
        const Text("帶字幕", style: TextStyle(fontSize: 18)),
      ],
    ),
  );
}
