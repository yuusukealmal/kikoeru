import 'package:flutter/material.dart';

Widget HomePageFooter(
  BuildContext context,
  int currentPage,
  int totalPages,
  TextEditingController _textController,
  Function(int) changePage,
) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 4,
      runSpacing: 4,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: currentPage > 1 ? () => changePage(currentPage - 1) : null,
        ),
        SizedBox(
          width: 40,
          child: TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, height: 1.2),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 5),
            ),
            onSubmitted: (value) {
              int? page = int.tryParse(value);
              FocusScope.of(context).unfocus();
              if (page != null && page >= 1 && page <= totalPages) {
                changePage(page);
              } else {
                _textController.text = currentPage.toString();
              }
            },
          ),
        ),
        Text(" / $totalPages", style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: currentPage < totalPages
              ? () => changePage(currentPage + 1)
              : null,
        ),
      ],
    ),
  );
}
