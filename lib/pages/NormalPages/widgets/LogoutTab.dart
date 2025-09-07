// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// pages
import "package:kikoeru/pages/NormalPages/pages/EntryPage.dart";

Future<void> logout(BuildContext context) async {
  await SharedPreferencesHelper.remove("USER.TOKEN");
  await SharedPreferencesHelper.remove("USER.RECOMMENDER.UUID");

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => EntryPage(title: "Kikoeru")),
  );
}

Widget logoutTab(BuildContext context) {
  return ListTile(
    title: const Text("Logout"),
    trailing: const Icon(Icons.logout_sharp),
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
                      "Logout Account",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Are you sure you want to Logout?",
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
                            await logout(context);
                          },
                          child: const Text(
                            "Logout",
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
