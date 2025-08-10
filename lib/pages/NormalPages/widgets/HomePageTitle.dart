// flutter
import 'package:flutter/material.dart';

// api
import 'package:kikoeru/api/WorkRequest/httpRequests.dart';

// pages
import 'package:kikoeru/pages/HomePage/pages/SearchPage.dart';

Widget HomePageTitle(
  BuildContext context,
  String title,
  TextEditingController _searchController,
) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            onSubmitted: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchWorksPage(
                    type: SearchType.STRING,
                    query: _searchController.text,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
