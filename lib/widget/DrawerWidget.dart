import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kikoeru/config/SharedPreferences.dart';
import 'package:kikoeru/config/ThemeProvider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(SharedPreferencesHelper.getString("USER.TOKEN") != null
                ? SharedPreferencesHelper.getString("USER.NAME") ?? "Not Login"
                : "Not Login"),
          ),
          ListTile(
            title: const Text('Reset Shared Preferences'),
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
                                    await SharedPreferencesHelper.delete();
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .init();
                                    Navigator.of(context).pop();
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
          ),
          if (SharedPreferencesHelper.getString("USER.TOKEN") != null)
            ListTile(
              title: const Text('Logout'),
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () async {
                                      await SharedPreferencesHelper.remove(
                                          "USER.TOKEN");
                                      await SharedPreferencesHelper.remove(
                                          "USER.RECOMMENDER.UUID");
                                      Navigator.of(context).pop();
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
            ),
        ],
      ),
    );
  }
}
