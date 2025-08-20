// flutter
import "package:flutter/material.dart";

// 3rd lib
import "package:provider/provider.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";
import "package:kikoeru/core/config/provider/ThemeProvider.dart";

Future<void> resetShard(BuildContext context) async {
  await SharedPreferencesHelper.delete();
  Provider.of<ThemeProvider>(context, listen: false).init();
}

Widget resetShardTab(BuildContext context) {
  return ListTile(
    title: const Text("Reset Shared Preferences"),
    trailing: const Icon(Icons.delete),
    onTap: () async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Material(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reset Shared Preferences",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Are you sure you want to Reset shared preferences?",
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () async {
                            await resetShard(context);
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
