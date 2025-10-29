// flutter
import "package:flutter/material.dart";

// config
import "package:kikoeru/core/config/SharedPreferences.dart";

// functions
import "package:kikoeru/pages/NormalPages/logic/Login.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    if (SharedPreferencesHelper.getString("USER.NAME") != null) {
      _accountController.text = SharedPreferencesHelper.getString("USER.NAME")!;
    }
    if (SharedPreferencesHelper.getString("USER.PASSWORD") != null) {
      _passwordController.text =
          SharedPreferencesHelper.getString("USER.PASSWORD")!;
    }

    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登入")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: "帳號"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "密碼",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async => await login(
                context,
                _accountController.text.trim(),
                _passwordController.text.trim(),
              ),
              child: Text("登入"),
            ),
          ],
        ),
      ),
    );
  }
}
